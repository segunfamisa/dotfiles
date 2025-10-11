#!/bin/zsh
# Android config
export ANDROID_HOME=~/Library/Android/sdk
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

ANDROID_NDK_HOME=~/Library/Android/ndk
if [ -e $ANDROID_NDK_HOME ]; then
  # add simple perf to path
  export PATH="$ANDROID_NDK_HOME/simpleperf:$PATH"
fi

# Perfetto set up
PERFETTO_HOME=$HOME/.perfetto
PERFETTO_RECORD_TRACE=$PERFETTO_HOME/record_android_trace
PERFETTO_HEAP_PROFILE=$PERFETTO_HOME/heap_profile
PERFETTO_HEAP_DUMP=$PERFETTO_HOME/java_heap_dump
# download record trace
if [ ! -f $PERFETTO_RECORD_TRACE ]; then
  mkdir -p $PERFETTO_HOME
  curl -Lo $PERFETTO_RECORD_TRACE https://raw.githubusercontent.com/google/perfetto/main/tools/record_android_trace
  chmod +x $PERFETTO_RECORD_TRACE
fi
# download heap profile
if [ ! -f $PERFETTO_HEAP_PROFILE ]; then
  mkdir -p $PERFETTO_HOME
  curl -Lo $PERFETTO_HEAP_PROFILE https://raw.githubusercontent.com/google/perfetto/main/tools/heap_profile
  chmod +x $PERFETTO_HEAP_PROFILE
fi
# download java heap dump
if [ ! -f $PERFETTO_HEAP_DUMP ]; then
  mkdir -p $PERFETTO_HOME
  curl -Lo $PERFETTO_HEAP_DUMP https://raw.githubusercontent.com/google/perfetto/refs/heads/main/tools/java_heap_dump
  chmod +x $PERFETTO_HEAP_DUMP
fi
export PATH="$PERFETTO_HOME:$PATH"

# H/T to Zarah Dominguez -> https://gist.github.com/zmdominguez/9a889f1c367e1a21203ce8527c81e612
function get_devices() {
  # Get the type to find (defaults to "a")
  # a=all, d=devices, e=emulators
  type_to_find=${1:-"a"}


  all_devices=$(command adb devices -l)

  # Drop the title
  all_devices=${all_devices#"List of devices attached"}

  # Drop any unauthorised devices (i.e. USB debugging disabled or authorisations revoked)
  valid_devices=$(echo "$all_devices" | grep -v "unauthorized" | grep -oE ".*?model:\S*")

  # Filter based on input
  if [[ $type_to_find == "e" ]]; then
    valid_devices=$(echo "$valid_devices" | grep -oE "^emulator.*$")
  elif [[ $type_to_find == "d" ]]; then
    valid_devices=$(echo "$valid_devices" | grep -v "^emulator.*$")
  fi

  # Find how many valid devices we have
  num_matches=$(echo "$valid_devices" | wc -l)

  # If there are multiple, ask for which device to grab
  if [[ $num_matches -gt 1 ]]; then
    get_from_multiple
  # Otherwise just grab the serial number
  else
    serial_number=$(echo "$valid_devices" | awk '{printf $1}')
  fi

  echo "$serial_number"
}

function get_from_multiple() {
  # Display device serial numbers
  find_matches=$(echo "$valid_devices" | awk 'match($0, /model:/) {print NR " - " $1 " (" substr($0, RSTART+6) ")"}')
  printf >&2 "Multiple devices found:\n%s\n" "$find_matches"

  # Present chooser
  echo >&2 -n "Select device: "
  read -r selected_device

  # Get the chosen serial number
  serial_number=$(echo "$find_matches" | grep -E "${selected_device} - (.*)" | awk '{print $3}')
}

# Grabs a serial number from all _available_ devices
# If there is only one device, grabs that serial number automatically
# If there are multiple devices, shows a chooser with the list of serial numbers
function getSerialNumber() {
  serial_number=$(get_devices)
}

# Sends an interactive ADB command
# Usage: Use the usual ADB command, replacing `adb` with `adbi`
function adbi() {
    getSerialNumber && adb -s "$serial_number" "$@"
}

function adb_talkback_on() {
  adbi shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService
}

function adb_talkback_off() {
  adbi shell settings put secure enabled_accessibility_services com.android.talkback/com.google.android.marvin.talkback.TalkBackService
}
