*** Settings ***
Library     Browser
Resource    ${EXECDIR}${/}Resources${/}POM${/}presta_items.robot
Variables   ${EXECDIR}${/}Resources${/}logvariables.py

*** Test Cases ***
Test For Logging Into Prestahop
    [Documentation]   This test case logs into Prestashop using the provided credentials.
    New Browser       chromium         headless=${False}   args=["--disable-blink-features=AutomationControlled"]
    New Page          ${PRESTA_URL}
    Click             xpath=${PRESTA_LOGIN_BTN}
    ${element}=       Get Element    xpath=${PRESTA_LOGIN_TA}
    Fill Text         ${element}     ${PRESTA_LOGIN}
    ${element}=       Get Element    xpath=${PRESTA_PASSWORD_TA}
    Fill Text         ${element}     ${PRESTA_PASSWORD}
    Click             xpath=${PRESTA_LSUBMIT_BTN}
    Close Browser 