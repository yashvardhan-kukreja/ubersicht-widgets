#!/usr/bin/env bash

lFan="$(./fan-bar.widget/osx-cpu-temp -f)"
cpuTemp="$(./fan-bar.widget/smctemp -c)"
gpuTemp="$(./fan-bar.widget/smctemp -g)"
echo $lFan 
echo " "$cpuTemp"ºC"
echo " "$gpuTemp"ºC"
