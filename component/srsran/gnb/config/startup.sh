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

# export GNB_IP=$(ping -c1 gnb_zmq | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
# export UE_IP=$(ping -c1 ue_zmq | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
# export GNB_IP="172.30.0.100"
# export UE_IP="172.30.0.101"
export GNB_IP=$(grep "$HOSTNAME" /etc/hosts|awk '{print $1}')

mkdir /etc/srsran
cp /mnt/config/${COMPONENT_NAME}.yml /etc/srsran/gnb.yml
cp /mnt/config/qos.yml /etc/srsran/qos.yml

for var in $(env | awk -F '=' '{print $1}') 
do 
	sed -i 's|$'$var'|'${!var}'|g' /etc/srsran/gnb.yml 2>/dev/null
done
cat /etc/srsran/gnb.yml
gnb -c /etc/srsran/gnb.yml -c /etc/srsran/qos.yml

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
