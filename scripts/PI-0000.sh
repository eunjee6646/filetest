#!/bin/bash

# SPDX-License-Identifier: GPL-2.0
# Copyright(c) 2023 CoAsia Nexell, Inc. and/or its affiliates.
# AUTHOR : <AUTHOR>
# E-MAIL : <EMAIL>

### Automatic generation - Do not Update
TEST_ID="PI-0000"
PROMPT_MSG="root@lava:/#"
TEST_LOG="${TEST_ID}.log"
TEST_OUT="TestCase_Result.txt"
FAIL_COUNT=0

### Test Config - Update
INTERVAL=0.5
IS_MSG_CLEAR=true

### Check Test Reult - Do not Update
function CHECK_RESULT {
	if [[ -n $TEST_PASS_PAT ]];then
		if [[ $CONSOLE_LOG != *$TEST_PASS_PAT* ]];then
			FAIL_COUNT=$((${FAIL_COUNT} + 1))
		fi
	fi
	if [[ -n $TEST_FAIL_PAT ]];then 
		if [[ $CONSOLE_LOG = *$TEST_FAIL_PAT* ]];then
			FAIL_COUNT=$((${FAIL_COUNT} + 1))
		fi
	fi

	sleep $INTERVAL
}

### Clear old messages - Do not Update
if [ $IS_MSG_CLEAR = true ];then
	dmesg -C
	sleep 0.1
fi

### Test Sequence - Update
echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "wget http://cnst.coasianexell.com:8082/artifactory/open_test/sdk.tar.gz" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`wget http://cnst.coasianexell.com:8082/artifactory/open_test/sdk.tar.gz | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT="saved"
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "tar -xvzf sdk.tar.gz" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`tar -xvzf sdk.tar.gz  | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT="sdk/"
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "pwd" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`pwd | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "find . -name 'sdk*'" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`find . -name 'sdk*' | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT


echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "ls -al" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`ls -al | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "chown -R root:root sdk" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`chown -R root:root sdk | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "chmod -R 777 sdk" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`chmod -R 777 sdk | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "ls -al" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`ls -al | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "cd ./sdk" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`cd ./sdk | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "pwd" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`pwd | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT=""
TEST_FAIL_PAT=""
CHECK_RESULT

#echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
#echo "ls -al" | tee -a $TEST_LOG &>/dev/null
#CONSOLE_LOG=`ls -al | tee -a $TEST_LOG` &>/dev/null
#TEST_PASS_PAT=""
#TEST_FAIL_PAT=""
#CHECK_RESULT

echo -n "$PROMPT_MSG " | tee -a $TEST_LOG &>/dev/null
echo "./ff_all.sh" | tee -a $TEST_LOG &>/dev/null
CONSOLE_LOG=`./ff_all.sh | tee -a $TEST_LOG` &>/dev/null
TEST_PASS_PAT="Sending"
TEST_FAIL_PAT=""
CHECK_RESULT

### Test Result - Do not Update
if [ $FAIL_COUNT -eq 0 ];then
	RESULT="PASS"
else
	RESULT="FAIL"
fi

echo "$TEST_ID : $RESULT" | tee -a $TEST_OUT
