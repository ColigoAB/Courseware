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

# Process each app
foreach ($app in $apps) {
    # Remove for all users (this is the key change)
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers
    
    # Remove provisioned packages
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq $app | Remove-AppxProvisionedPackage -Online
}

# Verify removal was successful
$remainingApps = Get-AppxPackage -AllUsers | Where-Object { $_.Name -in $apps }
$remainingProvisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -in $apps }

if ($remainingApps -or $remainingProvisioned) {
    # Some apps couldn't be removed
    Exit 1
} else {
    # All apps were successfully removed
    Exit 0
}
