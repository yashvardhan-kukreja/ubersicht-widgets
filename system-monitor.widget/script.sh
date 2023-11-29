#!/usr/bin/env bash

lFan="$(./system-monitor.widget/osx-cpu-temp -f)"
cpuTemp="$(./system-monitor.widget/smctemp -c)"
gpuTemp="$(./system-monitor.widget/smctemp -g)"
echo $lFan 
echo " "$cpuTemp"ºC"
echo " "$gpuTemp"ºC"
