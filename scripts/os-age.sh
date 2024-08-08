#!/bin/bash

current=$(date +%s)
startup=$(date -d "$(uptime -s)" +%s)
time_progression=$((current - startup))
days_difference=$((time_progression / 86400))
echo "$days_difference days"
