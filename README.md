# (Unofficial) Slack Dark Theme

## Install on macOS

Download [darkify-slack.sh](https://raw.githubusercontent.com/CaliCastle/slack-dark-theme/master/darkify-slack.sh) from this repo, then open your terminal and enter:

```bash
sudo sh /path/to/darkify-slack.sh
```

## Install on Windows

1. Download [this repo and unzip](https://github.com/CaliCastle/slack-dark-theme/archive/v0.1.zip)
2. Search for PowerShell and **run as administrator** and enter `Set-ExecutionPolicy Unrestricted` and enter **Y** when prompted
3. **Hold down Shift and right click** on the `darkify-slack.ps1` file (not the `.sh` file) from your unzipped folder and select `Copy as path`
4. Go back to PowerShell, paste it and hit enter, then enter **R** when prompted to run the script then it will execute the installation.
5. Finally, to protect your Windows system, re-enable script protection by entering: `Set-ExecutionPolicy Restricted`

### You're all set

It will automatically install the dark theme into slack for you, once installed successfully, terminal or PowerShell will display the `Dark mode has been installed to Slack.` message, then you just need **restart your Slack app** and you can start protecting your eyes from now! Yuussss!

-----

### Behind the Scenes

For Windows, Slack is likely located in `C:\Users\username\AppData\Local\slack\app-{version}\resources\app.asar.unpacked\src\static`
For macOS, it's located in `/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static`
And basically the installation just appends a snippet of JavaScript into the `ssb-interop.js` file:

```js
document.addEventListener("DOMContentLoaded", function () {
    $.ajax({
        url: "https://raw.githubusercontent.com/CaliCastle/slack-dark-theme/master/darkify.css",
        success: function (css) {
            $("<style></style>").appendTo("head").html(css);
        }
    });
});
```
