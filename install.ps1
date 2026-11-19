# dotFound launcher - install or update from the command line (Windows 10/11, x64).
#
#   irm https://github.com/Joshspeakman/dotfound/releases/latest/download/install.ps1 | iex
#
# Options (set before running):
#   $env:DOTFOUND_PORTABLE = '1'   portable copy in %LOCALAPPDATA%\Programs\dotFound (no installer)
#   $env:DOTFOUND_DESKTOP  = '1'   also add a desktop shortcut
#   $env:DOTFOUND_VERSION  = 'v0.1.0-alpha.1'   a specific release instead of the latest
#
# Downloads come only from the GitHub releases, and are checked against the release's
# SHA256SUMS.txt before anything runs.
& {
    $ErrorActionPreference = 'Stop'
    $ProgressPreference = 'SilentlyContinue'
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    $repo = 'Joshspeakman/dotfound'
    $base = if ($env:DOTFOUND_VERSION) { "https://github.com/$repo/releases/download/$($env:DOTFOUND_VERSION)" } else { "https://github.com/$repo/releases/latest/download" }
    $portable = $env:DOTFOUND_PORTABLE -eq '1'
    $asset = if ($portable) { 'dotFound-windows-x64.zip' } else { 'dotFound-Setup.exe' }
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ('dotfound-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory $tmp | Out-Null
    try {
        Write-Host "Downloading $asset ..."
        $file = Join-Path $tmp $asset
        Invoke-WebRequest "$base/$asset" -OutFile $file -UseBasicParsing
        $sumsFile = Join-Path $tmp 'SHA256SUMS.txt'
        Invoke-WebRequest "$base/SHA256SUMS.txt" -OutFile $sumsFile -UseBasicParsing
        $want = ''
        foreach ($line in Get-Content $sumsFile) {
            $parts = $line.Trim() -split '\s+', 2
            if ($parts.Count -eq 2 -and $parts[1].TrimStart('*') -eq $asset) { $want = $parts[0].ToLower() }
        }
        $got = (Get-FileHash $file -Algorithm SHA256).Hash.ToLower()
        if (-not $want -or $got -ne $want) { throw "Checksum mismatch for $asset (expected '$want', got '$got'). Nothing was installed." }
        Write-Host 'Checksum OK.'
        if ($portable) {
            $dest = Join-Path $env:LOCALAPPDATA 'Programs\dotFound'
            Get-Process dotFound -ErrorAction SilentlyContinue | Stop-Process -Force
            Start-Sleep -Milliseconds 500
            New-Item -ItemType Directory -Force $dest | Out-Null
            Expand-Archive $file -DestinationPath $dest -Force
            $exe = Join-Path $dest 'dotFound.exe'
            $sh = New-Object -ComObject WScript.Shell
            $lnk = $sh.CreateShortcut((Join-Path ([Environment]::GetFolderPath('Programs')) 'dotFound launcher.lnk'))
            $lnk.TargetPath = $exe; $lnk.WorkingDirectory = $dest; $lnk.Save()
            if ($env:DOTFOUND_DESKTOP -eq '1') {
                $d = $sh.CreateShortcut((Join-Path ([Environment]::GetFolderPath('Desktop')) 'dotFound launcher.lnk'))
                $d.TargetPath = $exe; $d.WorkingDirectory = $dest; $d.Save()
            }
            Write-Host "dotFound is in $dest (Start Menu: dotFound launcher)."
        } else {
            $tasks = if ($env:DOTFOUND_DESKTOP -eq '1') { '/TASKS=desktopicon' } else { '/TASKS=' }
            $p = Start-Process $file -ArgumentList '/VERYSILENT', '/SUPPRESSMSGBOXES', '/NORESTART', '/CURRENTUSER', $tasks -Wait -PassThru
            if ($p.ExitCode -ne 0) { throw "The installer stopped with code $($p.ExitCode)." }
            Write-Host 'dotFound launcher is installed (Start Menu: dotFound launcher).'
        }
    } finally {
        Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    }
}
