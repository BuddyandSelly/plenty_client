# frozen_string_literal: true

# PlentyClient::Config keeps its state in instance variables of the class object,
# so it survives between examples. These helpers put it back to a blank slate and
# to the "logged in" state most specs need.
module ConfigHelpers
  SETTINGS = %i[
    site_url api_user api_password access_token refresh_token log expiry_date
    plenty_id request_wait_until attempt_count open_timeout timeout
  ].freeze

  SITE_URL = 'https://www.example.com'
  ACCESS_TOKEN = 'ACCESS_TOKEN'
  REFRESH_TOKEN = 'REFRESH_TOKEN'

  def reset_config!
    SETTINGS.each { |setting| PlentyClient::Config.public_send("#{setting}=", nil) }
  end

  # Credentials plus tokens that are valid for a day, so #request goes straight
  # to the call instead of logging in first.
  def configure_client(**overrides)
    settings = {
      site_url: SITE_URL,
      api_user: 'example',
      api_password: 'secret',
      access_token: ACCESS_TOKEN,
      refresh_token: REFRESH_TOKEN,
      expiry_date: Time.now + 86_400
    }.merge(overrides)

    settings.each { |setting, value| PlentyClient::Config.public_send("#{setting}=", value) }
  end

  # Credentials without tokens, so #request has to log in first.
  def configure_credentials_only(**overrides)
    configure_client(access_token: nil, refresh_token: nil, expiry_date: nil, **overrides)
  end
end
