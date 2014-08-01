#!/system/bin/sh
# Copyright (c) 2014, Savoca <adeddo27@gmail.com>
# Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Disable MPD, enable intelliplug
if [ -e /sys/module/intelli_plug/parameters/intelli_plug_active ]; then
	stop mpdecision
	echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_active
	echo "[skydragon] IntelliPlug enabled" | tee /dev/kmsg
else
	echo "[skydragon] IntelliPlug not found, using MPDecision" | tee /dev/kmsg
	start mpdecision
fi

# Enable powersuspend
if [ -e /sys/kernel/power_suspend/power_suspend_mode ]; then
	echo "1" > /sys/kernel/power_suspend/power_suspend_mode
	echo "[skydragon] Powersuspend enabled" | tee /dev/kmsg
else
	echo "[skydragon] Failed to set powersuspend" | tee /dev/kmsg
fi

# Set CPU Clocks
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq ]; then
	echo "2265600" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo "2265600" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo "2265600" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo "2265600" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo "[skydragon] Max freq set: 2265600" | tee /dev/kmsg
else
	echo "[skydragon] Call the police!" | tee /dev/kmsg
fi

if [ -e /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ]; then
	echo "268800" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo "268800" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo "268800" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo "268800" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo "[skydragon] Min freq set: 268800" | tee /dev/kmsg
else
	echo "[skydragon] Call the police!" | tee /dev/kmsg
fi