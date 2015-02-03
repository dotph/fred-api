module SyncJob
  extend ActiveSupport::Concern

  def execute(action, path:, body:)
    token = authenticate

    if token
      execute_authenticated action, path: path, body: body, token: token
    else
      raise 'Authentication Failed'
    end
  end

  private

  def execute_authenticated(action, path:, body:, token:)
    response = HTTParty.send action,  path,
                                      headers: headers(token: token),
                                      body: body.to_json

    raise "Code: #{response.code}, Message: #{response.parsed_response}" if error_code response.code
  end

  def authenticate
    response = HTTParty.post  Rails.configuration.x.registry_authorization_url,
                              headers: headers,
                              body: authorization_request.to_json

    json_response = JSON.parse response.body, symbolize_names: true

    json_response[:token] unless error_code response.code
  end

  def authorization_request
    {
      username: Rails.configuration.x.registry_username,
      password: Rails.configuration.x.registry_password
    }
  end

  def headers token: nil
    {}.tap do |headers|
      headers['Authorization'] = "Token token=\"#{token}\"" if token
      headers['Content-Type']  = 'application/json'
    end
  end

  def error_code code
    (400..599).include? code
  end
end
