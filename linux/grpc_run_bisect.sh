#!/bin/bash
# Copyright 2017 gRPC authors.
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

GRPC_REPO_ROOT=$(dirname $0)/../../grpc

# clone the grpc/grpc repo
git clone --recursive https://github.com/grpc/grpc ${GRPC_REPO_ROOT} -o upstream

# change to grpc repo root
cd ${GRPC_REPO_ROOT}

source tools/internal_ci/helper_scripts/prepare_build_linux_rc

../grpc-bisect-tool/run_bisect.sh
