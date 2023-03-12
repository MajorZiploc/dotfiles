function slack_open {
  export SLACK_DEVELOPER_MENU=true;
  open -a /Applications/Slack.app;
}

function chrome_debug_open {
  sudo /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222;
}
