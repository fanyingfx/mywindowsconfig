Import-Module "gsudoModule"

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
# make tab complete using /
Set-PSReadLineKeyHandler -Chord  Tab -ScriptBlock {
  $content = ""
  $index = 0

  [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref] $content, [ref] $index)
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($content.Replace('\','/'))
  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($index)
}

Set-Variable Anki_redirect
Set-Alias -Name npd -Value 'C:\Program Files\Notepad3\Notepad3.exe'
Set-Alias -Name winsw -Value 'D:\Application\bin\WinSW-x64.exe'
Set-Alias -Name gd -Value 'C:\Program Files (x86)\GoldenDict\GoldenDict.exe'
Set-Alias -Name whisper-faster -Value 'D:\Whisper-Faster_r160.4_windows\Whisper-Faster\whisper-faster.exe'
Set-Alias -Name mpv -Value 'D:\Application\mpv-lazy\mpv.exe'

function Add-Path($Path) {

$Path = [Environment]::GetEnvironmentVariable("PATH", "USER") + [IO.Path]::PathSeparator + $Path
[Environment]::SetEnvironmentVariable( "Path", $Path, "User" )

}
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/craver.omp.json | Invoke-Expression

# Import the Chocolatey Profile that contains the necessary code to enable

# tab-completions to function for `choco`.

# Be aware that if you are missing these lines from your profile, tab completion

# for `choco` will not function.

# See https://ch0.co/tab-completion for details.

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Invoke-Expression (& { (zoxide init powershell | Out-String) })

if (Test-Path($ChocolateyProfile)) {

 Import-Module "$ChocolateyProfile"

}

#oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/honukai.omp.json | Invoke-Expression
function wsl-restart() {

 wsl --shutdown

$deviceId= (GET-CimInstance -query "SELECT * from Win32_DiskDrive"| Where Caption -like '*Fanxiang*').DeviceID

gsudo wsl --mount $deviceId --partition 1
Start-Sleep -s 3
wsl -e bash /home/fan/.profile
#wsl systemctl start lute3 --user
#wsl --exec dbus-launch true & bash

}
function virc(){
    nvim $PROFILE
  }
function scan-display(){
    gsudo pnputil /scan-devices /class "Display"
  }
function show-display(){
    pnputil /class "Display" /enum-devices
  }

function anki-redirect(){

python C:\Users\fan\Code\anki-redirect\main.py

}
function rime_update(){
  $repo_dir="D:\Code\rime-ice"
  $dst_dir="C:\Users\fanzh\AppData\Roaming\rime-ice"
git -C $repo_dir pull
gsudo {
$repo_dir="D:\Code\rime-ice"
$dst_dir="C:\Users\fanzh\AppData\Roaming\rime-ice"
cp -Recurse -Force "${repo_dir}\opencc" $dst_dir
cp -Recurse -Force "${repo_dir}\cn_dicts" $dst_dir
cp -Recurse -Force "${repo_dir}\en_dicts" $dst_dir
}

  }
function touch {if((Test-Path -Path ($args[0])) -eq $false) {Set-Content -Path ($args[0]) -Value ($null)} else {(Get-Item ($args[0])).LastWriteTime = Get-Date } }
