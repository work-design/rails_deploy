module KamalOverride
  module Configuration

    def proxy_image
      'ccr.ccs.tencentyun.com/kamal/kamal-proxy:v0.6.0'
    end

  end
end

Kamal::Configuration.prepend KamalOverride::Configuration
