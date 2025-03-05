$ErrorActionPreference = 'SilentlyContinue'
$apps = @(
    "Microsoft.BingNews",
    "Microsoft.BingWeather",
    "Microsoft.GamingApp",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MicrosoftOutlookForWindows",
    "Microsoft.People",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo"
)

# Changed to include -AllUsers parameter to check all user contexts
$foundApps = Get-AppxPackage -AllUsers | Where-Object { $_.Name -in $apps }

# Also check for provisioned packages to be thorough
$foundProvisionedApps = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -in $apps }

if ($foundApps -or $foundProvisionedApps) {
    Write-Output "Unwanted apps found"
    Exit 1
} else {
    Write-Output "No unwanted apps found"
    Exit 0
}
