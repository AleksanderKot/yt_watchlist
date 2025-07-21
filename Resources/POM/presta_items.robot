*** Variables ***
###   URLs    ###
${PRESTA_URL}              https://prestashop.dev.ttpsc.cloud/pl/

###  Buttons  ###
${PRESTA_LOGIN_BTN}        //span[text()='Zaloguj się']
${PRESTA_LSUBMIT_BTN}      //*[@id="submit-login"]

### Locators  ###
${PRESTA_LOGIN_TA}         //*[@id="field-email"]
${PRESTA_PASSWORD_TA}      //*[@id="field-password"]