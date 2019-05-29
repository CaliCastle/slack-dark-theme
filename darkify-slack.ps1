$slackBaseDir = "$env:LocalAppData\Slack"
$installations = Get-ChildItem $slackBaseDir -Directory | Where-Object { $_.Name.StartsWith("app-") }
$version = $installations | Sort-Object { [version]$_.Name.Substring(4) } | Select-Object -Last 1
Write-Output "Found Slack: v$version";

$installed = $false;
$darkModeScript = @'
// Load dark mode stylesheets
document.addEventListener("DOMContentLoaded", function () {;$.ajax({ url: "https://raw.githubusercontent.com/CaliCastle/slack-dark-theme/master/darkify.css", success: function (css) {$("<style></style>").appendTo("head").html(css);}});});
'@

if ((Get-Content "$($version.FullName)\resources\app.asar.unpacked\src\static\index.js" | %{$_ -match "// CaliCastle - slack-dark-theme"}) -notcontains $true) {
    Add-Content "$($version.FullName)\resources\app.asar.unpacked\src\static\index.js" $darkModeScript
    Write-Host "Dark theme has been installed to index.js";
    $installed = $true;
} else {
    Write-Host "Dark theme is detected in index.js, -- skipping --";
}

if ((Get-Content "$($version.FullName)\resources\app.asar.unpacked\src\static\ssb-interop.js" | %{$_ -match "// CaliCastle - slack-dark-theme"}) -notcontains $true) {
    Add-Content "$($version.FullName)\resources\app.asar.unpacked\src\static\ssb-interop.js" $darkModeScript
    Write-Host "Dark theme has been installed to ssb-interop.js";
    $installed = $true;
} else {
    Write-Host "Dark theme is detected in ssb-interop.js, -- skipping --";
}

if ($installed -eq $true) {
    if((Get-Process "slack" -ErrorAction SilentlyContinue) -ne $null) {
        Write-Host "Dark mode has been installed to Slack.";
    } else {
        Write-Host "Installation complete.";
    }
} else {
    Write-Host "Dark theme was already installed.";
}
