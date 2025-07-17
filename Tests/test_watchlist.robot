*** Settings ***
Library           Browser
Library           OperatingSystem
Library           String
Variables         ${EXECDIR}/Resources/logvariables.py
Resource          ${EXECDIR}/Resources/Keywords/keywords.robot

*** Test Cases ***
Log Into Youtube To Delete Watchlist
    [Documentation]      This test case logs into YouTube using the provided credentials.
    ${channels}=         Get File             ${EXECDIR}/Resources/channels.txt
    ${channels_list}=    Split String         ${channels}    \n

    Youtube Login
    Sleep                5s
    Go To                https://www.youtube.com/playlist?list=WL
    Sleep                5s
    FOR    ${channel}    IN    @{channels_list}
        Log                 Sprawdzam channel: ${channel}    console=${True}
        ${channel_type}=    Evaluate    type($channel).__name__
        Log                 Typ channel: ${channel_type}    console=${True}
        IF    $channel.strip() != ''
            Log                 Usuwam filmy kanału: ${channel}    console=${True}
            Delete Movies       ${channel}
        END
    END
    #Delete Movies        G.F. Darwin
    Sleep                5s
    Close Browser