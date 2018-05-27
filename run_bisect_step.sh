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

git submodule update --init  # submodules might have been updated in the past
make clean  # sometimes necessary to prevent build breakages 

# try to build, skipping broken builds
#python tools/run_tests/run_tests.py -l c -c dbg --build_only  || exit 125

#python tools/run_tests/run_tests.py -l c++ -c asan --build_only  || exit 125

#GRPC_ABORT_ON_LEAKS=1 python tools/run_tests/run_tests.py -l c++ -c asan -r 'End2endTest.ClientCancelsRequestStream/1' -n 500 -a 10 -j 20

#python tools/run_tests/run_tests.py -l c -c tsan --build_only  || exit 125

python tools/run_tests/run_tests.py -l c -c tsan --use_docker -t -r "h2_compress_test.retry_streaming_succeeds_before_replay_finished" -n 3000 -a 16 -j 20
# TODO: determine the right number of iterations
# TODO: determine the right regex to run

