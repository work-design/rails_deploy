# frozen_string_literal: true
module KamalOverride::Configuration::Validator
  module Proxy

    def validate!
      super

      if config['ssl_certificate_path'].present? && config['ssl_private_key_path'].blank?
        error 'Must set a private key path to use a custom SSL certificate'
      end

      if config['ssl_private_key_path'].present? && config['ssl_certificate_path'].blank?
        error 'Must set a certificate path to use a custom SSL private key'
      end
    end

  end
end

Kamal::Configuration::Validator::Proxy.prepend KamalOverride::Configuration::Validator::Proxy