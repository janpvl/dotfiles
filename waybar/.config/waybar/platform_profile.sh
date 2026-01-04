#!/bin/sh

if [ -r /sys/firmware/acpi/platform_profile ]; then
  profile=$(cat /sys/firmware/acpi/platform_profile)
else
  profile="unknown"
fi

echo "{\"alt\": \"$profile\"}"
