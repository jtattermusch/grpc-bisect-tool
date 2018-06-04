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

BAD_REVISION=upstream/master
# we assume the state a while ago is good
GOOD_REVISION=$(git rev-list -1 --before="2018-04-01 00:00" upstream/master)

git checkout "${BAD_REVISION}"

echo "Making sure that the test being bisected is failing on 'bad' revision"
../grpc-bisect-tool/run_bisect_step.sh && (echo "run_bisect_step needs to fail on 'bad' revision."; exit 1)

# bisect between good and bad revisions.
git bisect start "${BAD_REVISION}" "${GOOD_REVISION}" --

git bisect run ../grpc-bisect-tool/run_bisect_step.sh

git bisect reset       
