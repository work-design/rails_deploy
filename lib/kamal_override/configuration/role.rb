module KamalOverride::Configuration
  module Role

    def ensure_one_host_for_ssl
      if running_proxy? && proxy.ssl? && hosts.size > 1 && !proxy.custom_ssl_certificate?
        raise Kamal::ConfigurationError, "SSL is only supported on a single server unless you provide custom certificates?, found #{hosts.size} servers for role #{name}"
      end
    end

  end
end

Kamal::Configuration::Role.prepend KamalOverride::Configuration::Role