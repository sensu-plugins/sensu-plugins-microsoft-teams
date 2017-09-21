## Sensu-Plugins-Microsoft-Teams

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-microsoft-teams.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-microsoft-teams)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-microsoft-teams.svg)](https://badge.fury.io/rb/sensu-plugins-microsoft-teams)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-microsoft-teams.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-microsoft-teams)


## Functionality

## Files
 * bin/handler-microsoft-teams.rb

## Usage for handler-microsoft-teams.rb
```
{
  "microsoft-teams": {
    "webhook_url": "webhook url",
    "dashboard": "uchiwa url, add link to teams notification. Format: http://sensu.com/#/client/$DataCenter/, optional",
    "channel": "#notifications-room, optional defaults to webhook defined",
    "message_prefix": "optional prefix - can be used for mentions",
    "surround": "optional - can be used for bold(*), italics(_), code(`) and preformatted(```)",
    "bot_name": "optional bot name, defaults to webhook defined",
    "link_names": "optional - find and link channel names and usernames",
    "message_template": "optional description erb template file - /some/path/to/template.erb",
    "payload_template": "optional json payload template file (note: overrides most other template options.)",
    "template": "backwards-compatible alias for message_template",
    "proxy_address": "The HTTP proxy address (example: proxy.example.com)",
    "proxy_port": "The HTTP proxy port (if there is a proxy)",
    "proxy_username": "The HTTP proxy username (if there is a proxy)",
    "proxy_password": "The HTTP proxy user password (if there is a proxy)",
    "icon_url": "https://raw.githubusercontent.com/sensu/sensu-logo/master/sensu1_flat%20white%20bg_png.png",
    "icon_emoji": ":snowman:",
    "action_type": "The type of action - currently only OpenUri is supported",
    "action_name": "The text that will be displayed on screen for the action"
  }
}
```
## Usage for microsoft-teams.json
```
{
  "microsoft-teams": {
    "webhook_url": "https://outlook.office.com/webhook/AAAAAAA/IncomingWebhook/BBBBBBBB",
    "dashboard": "https://sensu.domain.tld/#/client/Sensu/",
    "action_type": "openuri",
    "action_name": "View in Sensu"
  }
}
```
## Installation

[Installation and Setup](https://sensu-plugins.io/docs/installation_instructions.html)

## Notes
