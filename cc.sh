#!/bin/bash -v
# Clear kernel cache
sync
echo 3 > /proc/sys/vm/drop_caches
