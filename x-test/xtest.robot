*** Settings ***
Documentation     This test executing OPTEE "xtestx" on a remote machine
...               and getting the test result.
Suite Setup       Run Keywords    Open Connection And Log In    Run Tee Supplicant
Suite Teardown    Run Keywords    Terminate Tee Supplicant    Close All Connections
Resource          resource-xtest.robot

*** Test Cases ***
Execute xtest regression test
    [Documentation]    Execute "xtest -t regression"
    Run Regression Test

Execute xtest benchmark test
    [Documentation]    Execute "xtest -t benchmark"
    Run Benchmark Test
