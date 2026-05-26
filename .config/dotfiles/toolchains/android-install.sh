#!/usr/bin/env bash
set -euo pipefail

readonly ANDROID_CLI_INSTALL_URL="https://dl.google.com/android/cli/latest/darwin_arm64/install.sh"
readonly PERFETTO_HOME="$HOME/.perfetto"

install_android_cli() {
  echo "Installing Android CLI..."
  curl -fsSL "$ANDROID_CLI_INSTALL_URL" | bash
}

install_perfetto_tool() {
  local name="$1"
  local url="$2"
  local destination="$PERFETTO_HOME/$name"

  echo "Installing $name..."
  curl -fsSL -o "$destination" "$url"
  chmod +x "$destination"
}

install_perfetto() {
  echo "Installing Perfetto tools to $PERFETTO_HOME..."
  mkdir -p "$PERFETTO_HOME"

  install_perfetto_tool \
    "record_android_trace" \
    "https://raw.githubusercontent.com/google/perfetto/main/tools/record_android_trace"

  install_perfetto_tool \
    "heap_profile" \
    "https://raw.githubusercontent.com/google/perfetto/main/tools/heap_profile"

  install_perfetto_tool \
    "java_heap_dump" \
    "https://raw.githubusercontent.com/google/perfetto/refs/heads/main/tools/java_heap_dump"
}

main() {
  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required but was not found." >&2
    exit 1
  fi

  install_android_cli
  install_perfetto

  echo "Android tooling installed successfully."
}

main "$@"
