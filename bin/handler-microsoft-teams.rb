#!/usr/bin/env ruby

# Copyright 2017 Jose Gaspar and contributors.
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.
#
# In order to use this plugin, you must first configure an incoming webhook
# integration in Microsoft Teams. You can create the required webhook by visiting 
# https://outlook.office.com/connectors/publish
#
# After you configure your webhook, you'll need the webhook URL from the connector.

require 'sensu-handler'
require 'json'

class MicrosoftTeams < Sensu::Handler
  option :json_config,
         description: 'Configuration name',
         short: '-j JSONCONFIG',
         long: '--json JSONCONFIG',
         default: 'microsoft-teams'

  def microsoft_teams_webhook_url
    get_setting('teams_url')
  end

  def proxy_address
    get_setting('proxy_address')
  end

  def proxy_port
    get_setting('proxy_port')
  end

  def proxy_username
    get_setting('proxy_username')
  end

  def proxy_password
    get_setting('proxy_password')
  end

  def dashboard_uri
    get_setting('dashboard')
  end

  def get_setting(name)
    settings[config[:json_config]][name]
  end

  def handle
    uri = URI(microsoft_teams_webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new("{uri.path}?#{uri.query}", 'Content-Type' => 'application/json')
    text = '{"text": "Hello World from Sensu"}'
    req.body = JSON.parse(text)
    
    response = http.request(req)
    verifiy_response(response)
  end

  def verify_response(response)
    case response
    when Net::HTTPSuccess
      true
    else
      raise response.error!
    end
  end

  def color
    color = {
      0 => '#36a64f',
      1 => '#FFCC00',
      2 => '#FF0000',
      3 => '#6600CC'
    }
    color.fetch(check_status.to_i)
  end

  def check_status
    @event['check']['status']
  end

  def translate_status
    status = {
      0 => :OK,
      1 => :WARNING,
      2 => :CRITICAL,
      3 => :UNKNOWN
    }
    status[check_status.to_i]
  end
end 
