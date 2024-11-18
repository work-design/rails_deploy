module KamalOverride
  module Configuration

    def proxy_image
      "ccr.ccs.tencentyun.com/kamal/kamal-proxy:#{PROXY_MINIMUM_VERSION}"
    end

  end
end

Kamal::Configuration.prepend KamalOverride::Configuration
