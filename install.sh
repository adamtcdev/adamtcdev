sudo apt update && sudo apt install --no-install-recommends -y $(
  apt-cache show ubuntu-desktop \
  | awk '/^Depends:/ {sub(/^Depends: /,""); gsub(",", "\n"); print}' \
  | sed 's/([^)]*)//g' \
  | awk -F'|' '{print $1}' \
  | xargs -n1 \
  | sort -u
)
