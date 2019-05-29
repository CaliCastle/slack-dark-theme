# (Unofficial) Slack Dark Theme

## Install on macOS

Download [darkify-slack.sh](https://raw.githubusercontent.com/CaliCastle/slack-dark-theme/master/darkify-slack.sh) from this repo, then open your terminal and enter:

```bash
sudo sh /path/to/darkify-slack.sh
```

## Install on Windows

Download [darkify-slack.ps1](https://github.com/CaliCastle/slack-dark-theme/archive/v0.1.zip), right click and select `Run with Powershell`, Windows Power Shell will execute the installation and exit when done.

### You're all set

It will automatically install the dark theme into slack for you, once installed successfully, terminal or PowerShell will display the `Dark mode has been installed to Slack.` message, then you just need **restart or reload (`Ctrl / Cmd + R`) your Slack app** and start protecting your eyes!

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
