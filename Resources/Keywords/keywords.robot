*** Settings ***
Library           Browser
Library           OperatingSystem
Variables         ${EXECDIR}${/}Resources${/}logvariables.py
Resource          ${EXECDIR}${/}Resources${/}POM${/}yt_items.robot

*** Keywords ***
Youtube Login
    [Documentation]   Opens YouTube and logs in with provided credentials.
    New Browser       chromium         headless=${False}   args=["--disable-blink-features=AutomationControlled"]
    New Page          ${YT_URL}
    Click             xpath=${COOKIES_OK}
    Click             xpath=${SIGN_IN}
    ${element}        Get Element      xpath=${LOGIN_TA}
    Fill Text         ${element}       ${YT_LOGIN}
    Click             xpath=${LOGIN_NEXT}
    ${element}        Get Element      xpath=${PASSWORD_TA}
    Fill Text         ${element}       ${YT_PASSWORD}
    Click             xpath=${PASSWORD_NEXT}

Delete Movies
    [Arguments]       ${CHANNEL_TO_DELETE}
    ${videos}=        Get Elements    xpath=${PLAYLIST_RENDERER}
    ${found}=         Set Suite Variable    ${False}
    Log               Keyword uruchomiony       console=${True}
    FOR    ${video}    IN    @{videos}
        Log                 Pętla uruchomiona       console=${True}
        ${channel_name}=    Evaluate JavaScript    ${video}    (el) => el.querySelector('div#byline-container a[href*="/@"]')?.textContent
        ${ns}=              Create Dictionary    channel_name=${channel_name}
        ${channel_name}=    Evaluate    str(channel_name).strip()    namespace=${ns}
        Log                 Stan found przed: ${found}       console=${True}
        IF    '${channel_name}' == '${CHANNEL_TO_DELETE}'
            Log                    USUWAM: ${channel_name}    console=${True}
            Delete Single Movie    ${video}
            Sleep                  2s
            Set Suite Variable     ${found}    ${True}
            BREAK
        END
    END
    Log           Stan found po: ${found}       console=${True}
    IF    ${found}
        Log                 Znaleziono film, puszczam pętle jeszcze raz        console=${True}
        Delete Movies       ${CHANNEL_TO_DELETE}
    END

Delete Single Movie
    [Arguments]             ${video}
    Evaluate JavaScript     ${video}         (el) => el.scrollIntoView({behavior: "smooth", block: "center"})
    Sleep                   1s
    Evaluate JavaScript     ${video}         (el) => el.querySelector('div#menu button#button')?.click()
    Sleep                   1s
    ${all_items}=           Get Elements     //ytd-menu-service-item-renderer
    IF    ${all_items}
        FOR    ${item}    IN    @{all_items}
            ${txt}=           Get Text    ${item}
            Log               MENUITEM: ${txt}
            ${ns}=            Create Dictionary    txt=${txt}
            ${found}=         Evaluate    'Usuń z' in txt or 'Remove from' in txt    namespace=${ns}
            Run Keyword If    ${found}    Click    ${item}
            Run Keyword If    ${found}    Sleep    2s
            Run Keyword If    ${found}    Exit For Loop
        END
    END