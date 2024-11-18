module KamalOverride::Configuration
  module Proxy
    extend ActiveSupport::Concern

    class_methods do
      def validation_doc
        @validation_doc ||= File.read(File.join(File.dirname(__FILE__), 'docs', "#{validation_config_key}.yml"))
      end
    end

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