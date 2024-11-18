module KamalOverride::Configuration
  module Proxy

    def deploy_options
      super.merge!(
        'tls-certificate-path': proxy_config['ssl_certificate_path'].presence,
        'tls-private-key-path': proxy_config['ssl_private_key_path'].presence
      ).compact
    end

    def custom_ssl_certificate?
      proxy_config['ssl_certificate_path'].present?
    end

  end
end

Kamal::Configuration::Proxy.prepend KamalOverride::Configuration::Proxy