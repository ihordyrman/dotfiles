### Purely for my working environments

### Variables ###
$nvimconfig = "C:\Users\Me\AppData\Local\nvim\init.vim"
$ideavimconfig = "C:\Users\Me\.ideavimrc"
$kubeconfig = "C:\Users\Me\.kube\config"

### Aliases ###
Set-Alias -Name k -Value kubectl

### Modules ###
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module PSReadLine

### Initialization ###
oh-my-posh init pwsh --config "C:\Program Files (x86)\oh-my-posh\themes\clean-detailed.omp.json" | Invoke-Expression
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -Colors @{ Command = 'Green' }
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

### Functions ###
function Get-RandomHash
{
    return [System.Guid]::NewGuid().ToString("N").Substring(0, 8)
}

function Get-FolderSize
{
    $command = "'{0} MB' -f ((Get-ChildItem . -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)"
    Invoke-Expression $command
}

function Rename-Files {
    param (
        [string]$oldPattern,
        [string]$newPattern
    )

    $files = Get-ChildItem . -Filter "*$oldPattern*" -Recurse -File

    foreach ($file in $files) {
        $newName = $file.Name -replace $oldPattern, $newPattern
        $newFullPath = Join-Path -Path $file.DirectoryName -ChildPath $newName

        Rename-Item -Path $file.FullName -NewName $newFullPath
        Write-Host ("Renamed " + $file.FullName + " to " + $newFullPath) -ForegroundColor Green
    }
}

function Clean-Projects
{
    Get-ChildItem .\ -include bin, obj -Recurse | foreach ($_) { Remove-Item $_.fullname -Force -Recurse }
}

function Get-KubernetesSecret
{
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)] [string] $name,
        [Parameter(Mandatory = $true)] [string] $namespace
    )

    $secret = kubectl get secret $name -n $namespace -o jsonpath = '{.data.*}' | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }
    return $secret
}

function hmm {
    param (
        [string]$searchString
    )
    Select-String -Path (Get-PSReadlineOption).HistorySavePath -Pattern $searchString | ForEach-Object { $_.Line }
}

function ports { 
    Get-NetTCPConnection | Select-Object LocalPort, OwningProcess, @{Name="ProcessName";Expression={(Get-Process -ID $_.OwningProcess).ProcessName}}
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
    Import-Module "$ChocolateyProfile"
}
