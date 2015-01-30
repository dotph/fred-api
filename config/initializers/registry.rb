config = Rails.application.config_for(:registry).with_indifferent_access

Rails.configuration.x.registry_url = config[:url]
Rails.configuration.x.registry_authorization_url = config[:url] + '/authorizations'
Rails.configuration.x.registry_username = config[:username]
Rails.configuration.x.registry_password = config[:password]
