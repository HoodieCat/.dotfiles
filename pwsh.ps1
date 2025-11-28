#modules
Import-Module git-aliases -DisableNameChecking
Import-Module PSReadline
Import-Module scoop-completion
#PSReadLine Options
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineOption -PredictionSource History
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+y' -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key 'Ctrl+q' -Function TabCompleteNext
#PSFzf keybindings
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'alt+c' -PSReadlineChordReverseHistoryArgs 'alt+a'
#
#use fd as the default finder
# $env:FZF_CTRL_T_COMMAND='fd --hidden --follow  --exclude node_modules --exclude .vscode --no-ignore'
# $env:FZF_ALT_C_COMMAND='fd --hidden -L -td -tl --exclude .git --exclude .vscode --no-ignore'
# $env:FZF_DEFAULT_OPTS='--layout=reverse  --height=80% '

oh-my-posh init pwsh --config 'C:\Users\lijie\AppData\Local\Programs\oh-my-posh\themes\agnoster.minimal.omp.json' | Invoke-Expression

# set alias
Set-Alias lg lazygit
Set-Alias vi nvim
Set-Alias omp oh-my-posh

function which {
    param ([string]$Command)
    Get-Command -Name $Command -ErrorAction SilentlyContinue | select -ExpandProperty Path -ErrorAction SilentlyContinue
}

function gh {
    cd ~
}

# yazi
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
	Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}
# fzf wrapper
