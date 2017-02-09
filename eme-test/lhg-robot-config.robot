*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           Selenium2Library    timeout=30
Library           Collections
Library           lhg-robot-libs.py

*** Variables ***
${TARGET}         'http://192.168.29.110:9515'
${TESTPAGE}       http://people.linaro.org/~naresh.kamboju/chrome/eme_player.html
${TEST VIDEO URL}    http://people.linaro.org/~arthur.she/chrome/Chrome_44-enc_av.webm
${KEY SYSTEM}     External Clearkey

*** Keywords ***
Prepare Browser
    ${capabilities}=    Create Dictionary
    ${extension_list}=    Create List
    ${args_list}=    Create List    --no-sandbox    --register-pepper-plugins=/usr/lib/chromium/libopencdmadapter.so;application/x-ppapi-open-cdm    --in-process-gpu
    Set To Dictionary    ${capabilities}    extensions    ${extension_list}
    Set To Dictionary    ${capabilities}    args    ${args_list}
    ${desired_capabilities}=    Create Dictionary    chromeOptions=${capabilities}
    ${executor}=    Evaluate    str(${TARGET})
    Create WebDriver    Remote    desired_capabilities=${desired_capabilities}    command_executor=${executor}
    Maximize Browser Window

Open Browser To Test Page
    Prepare Browser
    Go To    ${TESTPAGE}
    Wait Until Element Is Visible    id=keySystemList

Input Video URL
    [Arguments]    ${video_url}
    Input Text    id=mediaFile    ${video_url}

Select Key System
    [Arguments]    ${key_system}
    Select From List By Label    id=keySystemList    ${key_system}

Scroll Page Down To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);

Play Video
    Click Button    Play
