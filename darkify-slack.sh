#!/bin/sh
# Darkify Slack on Mac OS:

SLACK_INTEROP_JS="/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js"

if [ -z "`grep tt__customCss ${SLACK_INTEROP_JS}`" ]; then
    # Backup original CSS for reverts:
    cp ${SLACK_INTEROP_JS} ${SLACK_INTEROP_JS}.bak
    echo 'document.addEventListener("DOMContentLoaded", function () {;$.ajax({ url: "https://raw.githubusercontent.com/CaliCastle/slack-dark-theme/master/darkify.css", success: function (css) {$("<style></style>").appendTo("head").html(css);}});});' \
        >> ${SLACK_INTEROP_JS}
    echo "Dark mode has been installed to Slack."
else
    echo "Dark mode was already installed on Slack."
fi
