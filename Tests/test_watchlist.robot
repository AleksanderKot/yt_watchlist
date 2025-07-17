*** Settings ***
Library           Browser
Library           OperatingSystem
Variables         ${EXECDIR}${/}Resources${/}logvariables.py
Resource          ${EXECDIR}${/}Resources${/}Keywords${/}keywords.robot

*** Test Cases ***
Log Into Youtube To Delete Watchlist
    [Documentation]      This test case logs into YouTube using the provided credentials.
    Youtube Login
    Sleep                5s
    Delete Movies        IGN
    Sleep                5s
    Close Browser