#git-aliases
Import-Module git-aliases -DisableNameChecking
#readline
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

#oh-my-posh init
oh-my-posh init pwsh | Invoke-Expression

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
$env:FZF_DEFAULT_OPTS='--layout=reverse  --height=80%'

Set-PSReadlineKeyHandler -Key 'Ctrl+t' -ScriptBlock {
    $t = [Microsoft.Powershell.PSConsoleReadLine]::InputLine
    $c = [Microsoft.Powershell.PSConsoleReadLine]::CursorPosition
    $command = 'fd -tf --hidden --follow  --exclude node_modules --exclude .vscode --no-ignore  2>$null | fzf --walker file,dir,follow,hidden --border --scheme path --preview ''bat -n --color=always {}'' '
    try{
        $result = Invoke-Expression $command
        if($result){
            if($result -match " ") { $result = '"' + $result + '"'}
            [Microsoft.Powershell.PSConsoleReadLine]::Insert($result)
        }
    }
    catch {}
}

Set-PSReadLineKeyHandler -Key 'Alt+c' -ScriptBlock {
    $t = [Microsoft.Powershell.PSConsoleReadLine]::InputLine
    $command = 'fd -td -tl --hidden --follow --exclude .git --exclude node_modules --no-ignore 2>$null | fzf --scheme path --border --prompt=" Go To >" --preview ''tree {}'''
    try{
        $result = Invoke-Expression $command
        if ($result){
            if($result -match " ") { $result = '"'+$result+'"'}
            [Microsoft.Powershell.PSConsoleReadLine]::DeleteLine()
            [Microsoft.Powershell.PSConsoleReadLine]::Insert("cd $result")
            [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
        }
    }
    catch {}
}

Set-PSReadLineKeyHandler -Key 'Ctrl+r' -ScriptBlock {
    $initQuery = [Microsoft.Powershell.PSConsoleReadLine]::InputLine
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    $command = "Get-Content '$historyPath' -ErrorAction SilentlyContinue | Select-Object -Unique | fzf --no-sort --tac --prompt='History>' --scheme history --query '$initQuery'"
    try{
        $result = Invoke-Expression $command
        if($result){
            [Microsoft.Powershell.PSConsoleReadLine]::DeleteLine()
            [Microsoft.Powershell.PSConsoleReadLine]::Insert($result)
        }
    }
    catch{}
}

