#!/bin/bash
# TS , May 2016

# Part 1: Post a message to a slack channel as a custom BOT
# Part 2: Send a file as an attachment to Slack
# Note if you use the two parts in conjuction the file attachment will be delivered
# with the user/bot name associated with your token and not the custom name assigned in Part 1.

# Token for the BOT/User you want to post the message as:
TOKEN="<your-BOT-token>"
# Determine machine hostname
HOST="`hostname`"
# Determine the user logged into the machine
USER=$(whoami)
# Use Slack default icon. Edit value as needed.
ICOND=" "

# Part 1: Post a message to slack as a custom BOT
# Send your message as either the USER logged in to the machine or as the machine itself.
curl -F token=$TOKEN -F channel=<your-channel-id> -F text="<Add-Message-here>" -F username=<$HOST/$USER> -F as_user=false -F icon_emoji=:$ICOND:  https://slack.com/api/chat.postMessage
# Part 2: Send a file attachment to Slack
curl -F toekn=$TOKEN -F channel=<your-channel-id> -F file=@<filename> -F https://slack.com/api/files.upload

# You can combine the two to send the 1'st message form the user/machine and the second as the BOT associated with the token.
# curl -F toekn=$TOKEN -F channel=<your-channel-id> -F text="<Add-Message-here>" -F username=<$HOST/$USER> -F as_user=false -F icon_emoji=:$ICOND:  https://slack.com/api/chat.postMessage -F file=@<filename> -F https://slack.com/api/files.upload

exit 0
