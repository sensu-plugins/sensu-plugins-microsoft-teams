#!/usr/bin/env ruby

# Copyright 2017 Jose Gaspar and contributors.
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.
#
# In order to use this plugin, you must first configure an incoming webhook
# integration in Microsoft Teams. You can create the required webhook by
# visiting
# https://docs.microsoft.com/en-us/outlook/actionable-messages/actionable-messages-via-connectors#sending-actionable-messages-via-office-365-connectors
#
# After you configure your webhook, you'll need the webhook URL from the integration.

require 'sensu-handler'
require 'json'
require 'erubis'

class MicrosoftTeams < Sensu::Handler
  option :json_config,
         description: 'Configuration name',
         short: '-j JSONCONFIG',
         long: '--json JSONCONFIG',
         default: 'microsoft-teams'

  def payload_template
    get_setting('payload_template')
  end

  def teams_webhook_url
    get_setting('webhook_url')
  end

  def teams_icon_emoji
    get_setting('icon_emoji')
  end

  def teams_icon_url
    get_setting('icon_url')
  end

  def teams_channel
    @event['client']['teams_channel'] || @event['check']['teams_channel'] || get_setting('channel')
  end

  def teams_message_prefix
    get_setting('message_prefix')
  end

  def teams_bot_name
    get_setting('bot_name')
  end

  def teams_surround
    get_setting('surround')
  end

  def teams_link_names
    get_setting('link_names')
  end

  def teams_action_type
    get_setting('action_type')
  end

  def teams_action_name
    get_setting('action_name')
  end

  def message_template
    get_setting('template') || get_setting('message_template')
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

  def incident_key
    if dashboard_uri.nil?
      @event['client']['name'] + '/' + @event['check']['name']
    else
      "#{dashboard_uri}#{@event['client']['name']}?check=#{@event['check']['name']}"
    end
  end

  def get_setting(name)
    settings[config[:json_config]][name]
  end

  def handle
    if payload_template.nil?
      description = @event['check']['notification'] || build_description
      post_data("#{incident_key}: #{description}")
    else
      post_data(render_payload_template(teams_channel))
    end
  end

  def render_payload_template(channel)
    return unless payload_template && File.readable?(payload_template)
    template = File.read(payload_template)
    eruby = Erubis::Eruby.new(template)
    eruby.result(binding)
  end

  def build_description
    template = if message_template && File.readable?(message_template)
                 File.read(message_template)
               else
                 '''<%=
                 [
                   @event["check"]["output"].gsub(\'"\', \'\\"\'),
                   @event["client"]["address"],
                   @event["client"]["subscriptions"].join(",")
                 ].join(" : ")
                 %>
                 '''
               end
    eruby = Erubis::Eruby.new(template)
    eruby.result(binding)
  end

  def post_data(body)
    uri = URI(teams_webhook_url)
    http = if proxy_address.nil?
             Net::HTTP.new(uri.host, uri.port)
           else
             Net::HTTP::Proxy(proxy_address, proxy_port, proxy_username, proxy_password).new(uri.host, uri.port)
           end
    http.use_ssl = true

    req = Net::HTTP::Post.new("#{uri.path}?#{uri.query}", 'Content-Type' => 'application/json')

    if payload_template.nil?
      text = teams_surround ? teams_surround + body + teams_surround : body
      req.body = payload(text).to_json
    else
      req.body = body
    end

    response = http.request(req)
    verify_response(response)
  end

  def verify_response(response)
    case response
    when Net::HTTPSuccess
      true
    else
      raise response.error!
    end
  end

  def payload(notice)
    {
      themeColor: color,
      text: "#{@event['client']['address']} - #{translate_status}",
      sections: [{
        activityImage: teams_icon_url ? teams_icon_url : 'https://raw.githubusercontent.com/sensu/sensu-logo/master/sensu1_flat%20white%20bg_png.png',
        text: [teams_message_prefix, notice].compact.join(' ')
      }],
      potentialAction: [{
        '@type': teams_action_type ? teams_action_type : "OpenUri",
        name: teams_action_name ? teams_action_name : "View in Sensu",
        targets: [{
          os: "default",
          uri: "#{incident_key}" 
        }]
      }]
    }.tap do |payload|
      payload[:channel] = teams_channel if teams_channel
      payload[:username] = teams_bot_name if teams_bot_name
      payload[:icon_emoji] = teams_icon_emoji if teams_icon_emoji
      payload[:link_names] = teams_link_names if teams_link_names
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
