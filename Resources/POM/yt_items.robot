*** Variables ***
###   URLs    ###
${YT_URL}               https://www.youtube.com
${YT_WL_URL}            https://www.youtube.com/playlist?list=WL

###  Buttons  ###
${COOKIES_OK}           //*[@id="content"]/div[2]/div[6]/div[1]/ytd-button-renderer[2]/yt-button-shape/button
${SIGN_IN}              (//a[@aria-label="Sign in" and contains(@href, "ServiceLogin")])[1]
${LOGIN_NEXT}           //*[@id="identifierNext"]/div/button
${PASSWORD_NEXT}        //*[@id="passwordNext"]/div/button

###  Content  ###
${LOGIN_TA}             //*[@id="identifierId"]
${PASSWORD_TA}          //*[@id="password"]/div[1]/div/div[1]/input
${PLAYLIST_RENDERER}    //ytd-playlist-video-renderer 