# Firefox/application-services development

if [ -f "$HOME/.firefox.sh" ]; then
  . "$HOME/.firefox.sh"
fi

GYP_PATH="$HOME/tools/gyp"
if [ -d "$GYP_PATH" ]; then
  export PATH="$GYP_PATH:$PATH"
fi

export NSS_DIR="$HOME/Dev/firefox/tools/application-services/libs/desktop/darwin-aarch64/nss"
export NSS_STATIC=1
