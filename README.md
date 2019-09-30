## Sensu-Plugins-Microsoft-Teams

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-microsoft-teams.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-microsoft-teams)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-microsoft-teams.svg)](https://badge.fury.io/rb/sensu-plugins-microsoft-teams)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-microsoft-teams)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-microsoft-teams.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-microsoft-teams)

This plugin provides the ability to send alerts via Microsoft Teams.


## Screenshot
![Microsoft Teams Handler](screenshot.png)

## Functionality

## Files
 * bin/handler-microsoft-teams.rb

## Usage for handler-microsoft-teams.rb
```json
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
  },
  "handlers": {
    "microsoft-teams": {
      "type": "pipe",
      "command": "/opt/sensu/embedded/bin/handler-microsoft-teams.rb"
    }
  }
}
```
## Example for microsoft-teams.json
```json
{
  "microsoft-teams": {
    "webhook_url": "https://outlook.office.com/webhook/AAAAAAA/IncomingWebhook/BBBBBBBB",
    "dashboard": "https://sensu.domain.tld/#/client/Sensu/",
    "action_type": "openuri",
    "action_name": "View in Sensu"
  },
  "handlers": {
    "microsoft-teams": {
      "type": "pipe",
      "command": "/opt/sensu/embedded/bin/handler-microsoft-teams.rb"
    }
  }
}
```
## Installation

[Installation and Setup](https://docs.sensu.io/plugins/latest/installation/)

To install the plugin, run `sensu-install -p microsoft-teams`.

## Configuration

### Sensu Core

Configuring this plugin for Sensu Core requires its configuration file to live on disk. This file is typically found in `/etc/sensu/conf.d` and will look like the [example above](#usage-for-handler-microsoft-teamsrb). Sensu Core will load this configuration at runtime. 

### Sensu Go

Sensu Go represents a shift in configuration paradigms. Whereas Sensu Core requires configuration to live on disk, Sensu Go's configuration is API-driven. The exception to this is in handlers written for Sensu Core. Sensu community plugins written in Ruby still require a configuration file to live on-disk. So you will still need a configuration file like the one above. It will require 2 additional flags:

* `-j PATHTOCONFIGFILE`
* `--map_go_event_into_ruby`

See the following example:

```json
{
  "microsoft-teams": {
    "webhook_url": "https://outlook.office.com/webhook/AAAAAAA/IncomingWebhook/BBBBBBBB",
    "dashboard": "https://sensu.domain.tld/#/client/Sensu/",
    "action_type": "openuri",
    "action_name": "View in Sensu"
  },
  "handlers": {
    "microsoft-teams": {
      "type": "pipe",
        "command": "/opt/sensu/embedded/bin/handler-microsoft-teams.rb -j PATHTOCONFIGFILE ----map_go_event_into_ruby"
     }
  }
}
```

## Notes
[Actionable message card reference](https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference)
