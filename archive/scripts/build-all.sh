#!/bin/bash

bash /home/omair/work/lldb/lldb-dev/scripts/doit-sve.sh build-release-host

bash /home/omair/work/lldb/lldb-dev/scripts/doit-sve.sh build-release-aarch64

bash /home/omair/work/lldb/lldb-dev/scripts/doit-sve.sh build-debug-host

bash /home/omair/work/lldb/lldb-dev/scripts/doit-sve.sh build-debug-aarch64
