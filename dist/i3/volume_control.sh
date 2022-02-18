#!/usr/bin/env bash

VOLUME='+5%'
STATES=(`pactl list sinks | grep 'State:' | cut -b9-`);
SINKS=(`pactl list sinks | grep 'Sink' | cut -b7-`);

for i in "${!STATES[@]}"; do
  printf "i=%s State: %s Sink: %s\n" "$i" "${STATES[$i]}" "${SINKS[$i]}"
  if [[ "${STATES[$i]}" == "RUNNING" ]]; then
    echo "pactl -- set-sink-volume ${SINKS[$i]} $VOLUME"
  fi
done

# Set all vs running (main sink normally not running...)


