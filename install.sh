#!/bin/sh
# dotFound launcher - install, update or remove from the command line (Linux x86_64, macOS).
#
#   curl -fsSL https://github.com/Joshspeakman/dotfound/releases/latest/download/install.sh | sh
#   curl -fsSL .../install.sh | sh -s -- --uninstall
#
#   DOTFOUND_VERSION=v0.1.0-alpha.1  install a specific release instead of the latest
#
# Installs for your user only (no sudo): Linux into ~/.local, macOS into ~/Applications.
# Downloads come only from the GitHub releases and are checked against SHA256SUMS.txt.
set -eu
repo="Joshspeakman/dotfound"
if [ -n "${DOTFOUND_VERSION:-}" ]; then base="https://github.com/$repo/releases/download/$DOTFOUND_VERSION"; else base="https://github.com/$repo/releases/latest/download"; fi
os=$(uname -s)
arch=$(uname -m)

linux_paths() {
  share="$HOME/.local/share/dotfound"
  bin="$HOME/.local/bin/dotfound"
  desktop="$HOME/.local/share/applications/dotfound.desktop"
  icon="$HOME/.local/share/icons/hicolor/256x256/apps/dotfound.png"
}

if [ "${1:-}" = "--uninstall" ]; then
  case "$os" in
    Linux) linux_paths; rm -rf "$share" "$bin" "$desktop" "$icon"; echo "dotFound removed (your library stays in ~/.local/share/dotFound)." ;;
    Darwin) rm -rf "$HOME/Applications/dotFound launcher.app"; echo "dotFound removed (your library stays in ~/Library/Application Support/dotFound)." ;;
  esac
  exit 0
fi

case "$os-$arch" in
  Linux-x86_64) asset="dotFound-linux-x86_64.tar.gz" ;;
  Darwin-*) asset="dotFound-macos.tar.gz" ;;
  *) echo "dotFound has no build for $os $arch yet. See https://github.com/$repo/releases" >&2; exit 1 ;;
esac

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
echo "Downloading $asset ..."
curl -fsSL "$base/$asset" -o "$tmp/$asset" || { echo "No $asset in this release yet. See https://github.com/$repo/releases" >&2; exit 1; }
curl -fsSL "$base/SHA256SUMS.txt" -o "$tmp/SHA256SUMS.txt"
want=$(grep " $asset\$" "$tmp/SHA256SUMS.txt" | cut -d' ' -f1)
if command -v sha256sum >/dev/null 2>&1; then got=$(sha256sum "$tmp/$asset" | cut -d' ' -f1); else got=$(shasum -a 256 "$tmp/$asset" | cut -d' ' -f1); fi
[ -n "$want" ] && [ "$want" = "$got" ] || { echo "Checksum mismatch for $asset. Nothing was installed." >&2; exit 1; }
echo "Checksum OK."

tar -xzf "$tmp/$asset" -C "$tmp"
case "$os" in
  Linux)
    linux_paths
    mkdir -p "$share" "$(dirname "$bin")" "$(dirname "$desktop")" "$(dirname "$icon")"
    cp -R "$tmp/dotfound/." "$share/"
    ln -sf "$share/dotfound" "$bin"
    cp "$share/dotfound.png" "$icon"
    sed "s|^Exec=.*|Exec=$share/dotfound|" "$share/dotfound.desktop" > "$desktop"
    command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$(dirname "$desktop")" >/dev/null 2>&1 || true
    echo "dotFound launcher is installed: run 'dotfound' or open it from your app menu."
    case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) echo "(Add ~/.local/bin to your PATH to run 'dotfound' from a terminal.)" ;; esac
    ;;
  Darwin)
    mkdir -p "$HOME/Applications"
    rm -rf "$HOME/Applications/dotFound launcher.app"
    cp -R "$tmp/dotFound launcher.app" "$HOME/Applications/"
    xattr -dr com.apple.quarantine "$HOME/Applications/dotFound launcher.app" 2>/dev/null || true
    echo "dotFound launcher is in ~/Applications."
    ;;
esac
