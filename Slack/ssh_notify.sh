# Post SSH login information to your Slack channel
# Use in conjunction with a LaunchD that runs: tail -f /var/log/system.log | ssh_notify.sh
# Caveats : Only works if the SSH user is different from $USER on the client machine

#SSH_NOTIFY

while read line; do
  # Look for SSH authentication phrase in system.log
  # For VNC change to: *"Authentication: SUCCEEDED"*
  if [[ $line == *"Accepted keyboard-interactive/pam"* ]]; then
    sleep 2
    auth_users=`users`
    primary_user=$USER
    ssh_user=( "${auth_user[@]/$primary_user}" )
    # Grep IP for ssh_user
    IP=`who | grep $ssh_user | awk '{print $6}'`

    #Slack settings and additional variables
    url="<your-slack-webhook>"
    channel="<slack-channel-id>"
    host="`hostname`"

    #Define message content
    content="\"attachments\": [ { \"mrkdwn_in\": [\"text\", \"fallback\"], \"fallback\": \"SSH login: $ssh_user connected to \`$host\`\", \"text\": \"SSH login to \`$host\`\", \"fields\": [ { \"title\": \"User\", \"value\": \"$ssh_user\", \"short\": true }, { \"title\": \"IP Address\", \"value\": \"$IP\", \"short\": true } ], \"color\": \"#F35A00\" } ]"
    curl -X POST --data-urlencode "payload={\"channel\": \"$channel\", \"mrkdwn\": true, \"username\": \"<bot-name>\", $content, \"icon_emoji\": \":computer:\"}" $url
  fi
done  
