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

CURRENT_COMMIT=$(git rev-parse HEAD)

git submodule update --init  # submodules might have been updated in the past

make clean  # sometimes necessary to prevent build breakages 

# try to build, skipping broken builds
#python tools/run_tests/run_tests.py -l c -c dbg --build_only  || exit 125

python tools/run_tests/run_tests.py -l c++ -c dbg --use_docker -t -r ".*RpcDeadlineExpires" -n 100 --quiet_success -a 16 -j 20 -x ${CURRENT_COMMIT}_sponge_log.xml --report_suite_name ${CURRENT_COMMIT}


# TODO: determine the right number of iterations
# TODO: determine the right regex to run

