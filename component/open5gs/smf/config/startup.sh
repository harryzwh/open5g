#!/bin/bash

# BSD 2-Clause License

# Copyright (c) 2020, Supreeth Herle
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

export LD_LIBRARY_PATH=/open5gs/install/lib/$(uname -m)-linux-gnu
cp /mnt/config/${COMPONENT_NAME}.yaml install/etc/open5gs
cp /mnt/config/smf.conf install/etc/freeDiameter
cp /mnt/config/make_certs.sh install/etc/freeDiameter

# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8
# export IP_ADDR=$(awk 'END{print $1}' /etc/hosts)
# export IF_NAME=$(ip r | awk '/default/ { print $5 }')
export SMF_IP=$(ping -c1 smf | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
export PCRF_IP="127.0.0.1"

for var in $(env | awk -F '=' '{print $1}') 
do 
	sed -i 's|$'$var'|'${!var}'|g' /open5gs/install/etc/open5gs/${COMPONENT_NAME}.yaml 2>/dev/null
	sed -i 's|$'$var'|'${!var}'|g' /open5gs/install/etc/freeDiameter/smf.conf 2>/dev/null
	sed -i 's|$'$var'|'${!var}'|g' /open5gs/install/etc/freeDiameter/make_certs.sh 2>/dev/null
done
cat /open5gs/install/etc/open5gs/${COMPONENT_NAME}.yaml
cat /open5gs/install/etc/freeDiameter/smf.conf
/open5gs/install/etc/freeDiameter/make_certs.sh install/etc/freeDiameter

cd /open5gs/install/bin && ./open5gs-${COMPONENT_NAME}d

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
