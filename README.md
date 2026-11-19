<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/logo-dark.png">
    <source media="(prefers-color-scheme: light)" srcset="docs/logo-light.png">
    <img src="docs/logo-light.png" width="420" alt="dotFound launcher">
  </picture>
</p>

<p align="center"><em>every game you forgot you had.found.</em></p>

<p align="center">
  <a href="https://ko-fi.com/speakerjosh"><img src="https://img.shields.io/badge/Buy_me_a_Continue_%7C_%245-FF5E5B?style=for-the-badge&logo=ko-fi&logoColor=white" alt="Buy me a Continue on Ko-fi"></a>
</p>

<p align="center">
  A clean, fast game launcher that finds every game on your PC — Steam, GOG, Epic, Xbox, Battle.net,
  installers, portable folders, mods, recompiled and decompiled ports, and the emulators you play them
  with — dresses each one in real artwork, and puts them all on one shelf.
</p>

<p align="center">
  <a href="https://github.com/Joshspeakman/dotfound/releases/latest"><b>Download the latest release</b></a>
  &nbsp;·&nbsp; <a href="#install-from-the-command-line">Command line</a>
  &nbsp;·&nbsp; <a href="#platforms">Platforms</a>
  &nbsp;·&nbsp; <a href="LICENSE.txt">License</a>
</p>

<p align="center"><img src="docs/cover-flow.png" alt="dotFound in Cover flow: Half-Life, with its artwork, description and play time"></p>

> **Beta.** dotFound 0.1 beta is feature-complete and stable in daily use on Windows; Linux is newer and
> macOS is in testing. Please report anything odd in [Issues](https://github.com/Joshspeakman/dotfound/issues).

## Download

| System | Download | |
|---|---|---|
| **Windows 10 / 11** (x64) | [**dotFound-Setup.exe**](https://github.com/Joshspeakman/dotfound/releases/latest/download/dotFound-Setup.exe) | Installer for your user, no admin needed |
| Windows, portable | [dotFound-windows-x64.zip](https://github.com/Joshspeakman/dotfound/releases/latest/download/dotFound-windows-x64.zip) | Unzip anywhere, run `dotFound.exe` |
| **Linux** (x86_64) | [dotFound-linux-x86_64.tar.gz](https://github.com/Joshspeakman/dotfound/releases/latest/download/dotFound-linux-x86_64.tar.gz) | Ubuntu 22.04+, Debian 12+, Fedora 36+, SteamOS, or any distro with glibc 2.35+. Or use the one-line install below |
| **macOS** | Coming soon | Watch the [releases](https://github.com/Joshspeakman/dotfound/releases) |

These links always point at the newest release. Every release also lists its files with
[SHA-256 checksums](https://github.com/Joshspeakman/dotfound/releases/latest/download/SHA256SUMS.txt).

**Windows says "Windows protected your PC"?** Beta builds aren't code-signed yet. Click **More info**,
then **Run anyway**. You can check the download against `SHA256SUMS.txt` first
(`Get-FileHash dotFound-Setup.exe`).

## Install from the command line

**Windows** (PowerShell):

```powershell
irm https://github.com/Joshspeakman/dotfound/releases/latest/download/install.ps1 | iex
```

Set `$env:DOTFOUND_PORTABLE = '1'` first for a portable copy, `$env:DOTFOUND_DESKTOP = '1'` for a desktop
shortcut, or `$env:DOTFOUND_VERSION = 'v0.1.0-beta.1'` for a specific release. The script checks the
download against the release's checksums before it runs anything.

**Linux** (installs for your user, no sudo; macOS joins when its build is in the release):

```sh
curl -fsSL https://github.com/Joshspeakman/dotfound/releases/latest/download/install.sh | sh
```

Remove it again with `curl -fsSL .../install.sh | sh -s -- --uninstall` (your library is kept).

**With the GitHub CLI**:

```sh
gh release download --repo Joshspeakman/dotfound --pattern 'dotFound-Setup.exe'          # Windows installer
gh release download --repo Joshspeakman/dotfound --pattern 'dotFound-linux-x86_64.tar.gz' # Linux
gh release download --repo Joshspeakman/dotfound --pattern 'SHA256SUMS.txt'               # checksums
```

Silent install for scripts and deployment: `dotFound-Setup.exe /VERYSILENT /SUPPRESSMSGBOXES /CURRENTUSER`
(add `/TASKS=desktopicon` for a desktop shortcut). Uninstall from Settings > Apps, or run
`unins000.exe /VERYSILENT` in the install folder.

## What it does

- **Finds everything.** Steam (including libraries Steam forgot), GOG, Epic, Xbox, Battle.net, the
  Windows uninstall list, and games anywhere on your drives: dotFound looks through every folder for
  clear signs of a game (a store's marker, an engine's files, game-only middleware), so you don't add
  folders by hand. One entry per game, even when you own it twice: pick which **version** plays.
- **Tells games apart, even in one folder.** Games Steam installs together (Half-Life, Counter-Strike,
  Team Fortress Classic and Day of Defeat share one folder) each get their own entry, and so do mods
  that are games of their own (a Half-Life mod like Brutal Half-Life, a Source mod) — started the way
  Steam starts them, with their own play time.
- **Emulators and frontends too.** DuckStation, PCSX2, RPCS3, Dolphin, Cemu, RetroArch, ES-DE and more
  are found and listed, tagged *Emulator* or *Frontend* so they never pass for games (Settings can
  hide them).
- **Knows what recomps are.** Recompilations, decompilation ports, source ports and emulated games are
  recognised from the install itself and shown under their own name (Zelda 64: Recompiled, Dusklight,
  Ship of Harkinian…), with the game they bring back, their authors, version and project page.
- **Real artwork for every game.** Covers, backdrops, logos and icons from Steam, GOG, console box art,
  GitHub, the LaunchBox Games Database and SteamGridDB (optional free key) — and when nothing exists,
  dotFound draws a cover itself. Matches are checked: a mod never takes the art of the game it's built
  on, a sequel never the first game's. Nothing is left blank. ScreenScraper (videos, manuals, more box
  art) is built in too; for now it needs a ScreenScraper developer login entered in Settings.
- **Your pick, your pictures.** *Choose artwork* shows everything the sources offer for a game, side by
  side, for its box art, background and logo; or drop in your own picture. Your choice stays, whatever
  gets fetched later.
- **Your info.** *Edit info* lets you write or correct a game's description, genres, developer,
  publisher, release date and players.
- **Real music only.** A game's theme is its own soundtrack (a Steam soundtrack, the music it ships with,
  or its project's files) — never trailer audio. Or play your own music instead.
- **Four layouts, any window.** Cover flow, Grid, List and Wheel, in four themes and eight accent
  colours. Works at any size and orientation, from a tall portrait screen to a 420 px window.
- **Mouse, keyboard, touch and controllers.** Xbox, PlayStation, Nintendo and generic pads, with the
  right button prompts for the one in your hands.
- **Jump back in.** It opens on the game you played last, with play time from Steam and from dotFound.
- **Smart filters.** Genre, series, platform, era and source.
- **Hide games** you don't want on the shelf. Hidden games open from Settings, behind a PIN if you like.
- **Updates itself.** dotFound checks for a new release when it starts (you can turn that off), and
  installs it in place, checked against the release's checksums, keeping your settings and library.
  It waits until you close the game you're playing, and if something stops it (no connection,
  GitHub's hourly limit), it says so.
- **No more shader stutter** (Windows): with [Preheat](https://github.com/Joshspeakman/SCSKiller)
  installed, dotFound offers to compile a game's shaders before you play it.
- **Uninstalls cleanly**, through the game's own uninstaller or launcher, or to the Recycle Bin (the Trash
  on Linux).
- **Light.** Idle, it uses about 0.02% CPU; minimised or while you play, it lets go of its memory.

<p align="center">
  <img src="docs/grid.png" width="49%" alt="Grid layout, Midnight theme, Sky accent: Clair Obscur: Expedition 33 with its screenshots">
  <img src="docs/list.png" width="49%" alt="List layout, Teal accent: PCSX2, found and tagged as an emulator">
</p>
<p align="center">
  <img src="docs/wheel.png" width="49%" alt="Wheel layout, Arcade theme, Coral accent: Vampire Survivors with its gameplay video">
  <img src="docs/choose-artwork.png" width="49%" alt="Choose artwork for Diablo: box art, backgrounds and logos from GOG and SteamGridDB">
</p>

## Platforms

| | Windows | Linux | macOS |
|---|---|---|---|
| Steam games | ✔ | ✔ (native and Flatpak Steam) | In testing |
| GOG, Epic, Xbox, Battle.net, uninstall list | ✔ | — (Windows stores) | — |
| Portable folders | ✔ | Native games in `~/Games` and folders you add | In testing |
| Windows `.exe` games outside Steam | ✔ | Through Wine, when installed | — |
| Artwork, layouts, themes | ✔ | ✔ | In testing |
| Music and controllers | ✔ | Built in, not yet tested on Linux | In testing |
| Shader pre-compiling (Preheat) | ✔ | — | — |

Linux needs a desktop session (X11 or Wayland), OpenGL and glibc 2.35 or newer.

## Privacy

dotFound has no accounts and sends no analytics. To find artwork and details it asks public sources
about the games it finds: the Steam store, GOG, Wikipedia, the libretro thumbnail library and GitHub;
it downloads the LaunchBox Games Database's public catalogue (about 110 MB, once a month, without sending
any game names); and SteamGridDB and ScreenScraper only if you add a key or login. To look for updates
it asks GitHub for dotFound's latest release (Settings → About turns this off). Your library, settings and play
history stay on your PC (`%APPDATA%\dotFound`; `~/.local/share/dotFound` on Linux). Keys and passwords
you enter are encrypted for your Windows user on Windows; on Linux they are scrambled with a key file
that only your user can read.

## License

dotFound is free to download and use for personal, non-commercial purposes. It is **not open source**:
all rights are reserved. You may not copy, modify, redistribute, rebrand or sell it, or use its code
in another product. "dotFound", the ".found" wordmark, the tagline and the icon are the author's
trademarks. Read the full [license](LICENSE.txt). Open-source components dotFound includes are listed,
with their licenses, in `THIRD-PARTY-NOTICES.txt` inside every download.

Game names and artwork belong to their owners.

## Insert Coin

If this saved you some time (or saved you from buying something twice), you can buy me a Continue on Ko-fi. It's $5 and it keeps me building stuff like this.

[![Buy me a Continue on Ko-fi](https://img.shields.io/badge/Buy_me_a_Continue_%7C_%245-FF5E5B?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/speakerjosh)

<p align="center"><sub>Copyright © 2026 Joshspeakman. All rights reserved.</sub></p>
