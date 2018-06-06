#!/bin/bash
# Copyright 2018 The gRPC Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

CURRENT_SHA_SHORT=$(git show -s --format=%h)
# if bisecting hasn't started yet, BISECT_STEP will be set to 0.
BISECT_STEP=$(git bisect log | grep -e '^git bisect start' -e '^git bisect good' -e '^git bisect bad' | wc -l | tr -d ' \n')

REPORT_NAME="tests_step${BISECT_STEP}_${CURRENT_SHA_SHORT}/sponge_log.xml"

git submodule update --init  # submodules might have been updated in the past
make clean  # sometimes necessary to prevent build breakages 

# try to build, skipping broken builds
#python tools/run_tests/run_tests.py -l c -c dbg --build_only  || exit 125

#python tools/run_tests/run_tests.py -l c++ -c asan --build_only  || exit 125

python tools/run_tests/run_tests.py -l c++ -c asan --use_docker -t -r 'ClientCancelsRequestStream' --force_use_pollers epollex -n 5000 -a 40 -j 40 --quiet_success -x "${REPORT_NAME}"

#python tools/run_tests/run_tests.py -l c -c opt --use_docker -t -r 'httpcli_test' -n 2000 -a 40 -j 30

#python tools/run_tests/run_tests.py -l c++ -c opt -t -r 'H2SslCertTest.SimpleRequestBody' -n 3000 -a 4 -j 20

#python tools/run_tests/run_tests.py -l c++ -c dbg -t -r 'grpclb_end2end_test.*SingleBalancerTest.SecureNaming' -n 2000 -a 4 -j 10

#python tools/run_tests/run_tests.py -l c++ -c opt -t -r 'ClientLbEnd2endTest.RoundRobinSingleReconnect' -n 2000 -a 4 -j 10

#python tools/run_tests/run_tests.py -l c -c dbg -t -r 'h2_full_test.graceful_server_shutdown' -n 2000 -a 4 -j 10

#python tools/run_tests/run_tests.py -l c++ -c dbg -t -r 'grpclb_end2end_test.*SingleBalancerTest.SecureNaming' -n 2000 -a 4 -j 10

#python tools/run_tests/run_tests.py -l c -c tsan --build_only  || exit 125

#python tools/run_tests/run_tests.py -l c -c tsan --use_docker -t -r "h2_compress_test.retry_streaming_succeeds_before_replay_finished" -n 3000 -a 16 -j 20

#python tools/run_tests/run_tests.py -l c -c tsan --use_docker -t -r "h2_proxy_test.*max_message_length" -n 3000 -a 16 -j 20

#python tools/run_tests/run_tests.py -l c++ -c dbg --use_docker -t -r ".*RpcDeadlineExpires" -n 3000 -a 16 -j 20


# TODO: determine the right number of iterations
# TODO: determine the right regex to run

