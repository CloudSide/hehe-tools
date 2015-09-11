#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

#/bin/awk '/MemTotal|MemFree|SwapTotal|SwapFree/ { \
`which awk` '/MemTotal|MemFree|SwapTotal|SwapFree|Active/ { \
           print substr($1, 1, length($1)-1) "=" substr($2, 1, length($2)-3) "M"; \
        }' /proc/meminfo