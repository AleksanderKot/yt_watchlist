*** Settings ***
Library           Browser
Library           OperatingSystem
Variables         ${EXECDIR}${/}Resources${/}logvariables.py

*** Keywords ***
Youtube Login 
    [Documentation]   Opens YouTube and logs in with provided credentials.
    New Browser       chromium         headless=${False}   args=["--disable-blink-features=AutomationControlled"]
    New Page          https://www.youtube.com
    Click             xpath=//*[@id="content"]/div[2]/div[6]/div[1]/ytd-button-renderer[2]/yt-button-shape/button
    Click             xpath=(//a[@aria-label="Sign in" and contains(@href, "ServiceLogin")])[1]
    ${element}        Get Element      xpath=//*[@id="identifierId"]
    Fill Text         ${element}       ${YT_LOGIN}
    Click             xpath=//*[@id="identifierNext"]/div/button
    ${element}        Get Element      xpath=//*[@id="password"]/div[1]/div/div[1]/input
    Fill Text         ${element}       ${YT_PASSWORD}
    Click             xpath=//*[@id="passwordNext"]/div/button

Delete Movies
    [Documentation]   Delete movies from the watchlist
    [Arguments]       ${CHANNEL_TO_DELETE}
    Go To             https://www.youtube.com/playlist?list=WL
    Sleep             2s
    ${deleted}=    Set Variable    ${True}
    WHILE    ${deleted}
        ${deleted}=    Set Variable    ${False}
        Sleep          2s
        ${videos}=     Get Elements     xpath=//ytd-playlist-video-renderer
        FOR    ${video}    IN    @{videos}
            ${channel_name}=    Evaluate JavaScript    ${video}    (el) => el.querySelector('div#byline-container a[href*="/@"]')?.textContent
            ${ns}=    Create Dictionary    channel_name=${channel_name}
            ${channel_name}=    Evaluate    str(channel_name).strip()    namespace=${ns}
            Run Keyword If      '${channel_name}' == '${CHANNEL_TO_DELETE}'    Delete Single Movie    ${video}
            Run Keyword If      '${channel_name}' == '${CHANNEL_TO_DELETE}'    Set Variable    ${deleted}    ${True}
            Run Keyword If      '${channel_name}' == '${CHANNEL_TO_DELETE}'    Exit For Loop
        END
    END

Delete Single Movie
    [Arguments]       ${video}
    Evaluate JavaScript    ${video}    (el) => el.scrollIntoView({behavior: "smooth", block: "center"})
    Sleep             1s
    Evaluate JavaScript    ${video}    (el) => el.querySelector('div#menu button#button')?.click()
    Sleep             1s
    ${all_items}=     Get Elements    //ytd-menu-service-item-renderer
    FOR    ${item}    IN    @{all_items}
        ${txt}=    Get Text    ${item}
        Log    MENUITEM: ${txt}
        ${ns}=    Create Dictionary    txt=${txt}
        ${found}=    Evaluate    'Usuń z' in txt or 'Remove from' in txt    namespace=${ns}
        Run Keyword If    ${found}    Click    ${item}
        Run Keyword If    ${found}    Sleep    2s
        Run Keyword If    ${found}    Exit For Loop
    END