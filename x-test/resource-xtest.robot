*** Settings ***
Documentation     A resource file with reusable keywords and variables for xtest.
...
Library           SSHLibrary
Library           String

*** Variables ***
${HOST}           192.168.29.110
${USERNAME}       root
${PASSWORD}       ${EMPTY}

*** Keywords ***
Open Connection And Log In
    Open Connection    ${HOST}
    Login    ${USERNAME}    ${PASSWORD}
    Set Client Configuration    timeout=40s    prompt=root@hikey:~#

Run Tee Supplicant
    Start Command    /usr/bin/tee-supplicant

Terminate Tee Supplicant
    Start Command    pkill tee-supplicant

Run Regression Test
    write    xtest -t regression
    ${result}    Read Until Prompt
    Should Contain    ${result}    TEE test application done!

Run Benchmark Test
    write    xtest -t benchmark
    ${result}    Read Until Prompt
    Should Contain    ${result}    TEE test application done!
