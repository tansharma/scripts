#!/bin/bash
# TS , May 2016
# Tail the contents of a file and send them to a dedicated slack channel.
# Required incoming-webhook integration for slack.

# ---- SLACK Property Definitions ---- #
# Webhook URL for Slack Channel.
URL="<your-incoming-webhook-url>"

# ---- Definitions ---- #
# Determine machine hostname
HOST="`hostname`"
# Determine the user logged into the machine
USER=$(whoami)
# Path for file to tail/cat
FILE=$(tail file-name)

content="\"attachments\": [ { \"mrkdwn_in\": [\"text\", \"fallback\"], \"fallback\": \"Message from: \`$USER\`\", \"text\": \"Message From $USER @ $HOST\", \"fields\": [ { \"title\": \"<MESSAGE_TYPE e.g: Report>\", \"value\": \"$FILE\", \"short\": true } ], \"color\": \"#04B431\" } ]"

# Send post to the SLACK:
# Define _base_ text. ( eg. Server Report Attached )
# Use machine HostName as Username
# Attach $content (as defined above)
curl -X POST --data-urlencode "payload={\"mrkdwn\": true, \"text\": \"<enter-message-here>\", \"username\": \"$HOST\", $content, \"icon_emoji\": \":$ICOND:\" }" $URL

exit 0
