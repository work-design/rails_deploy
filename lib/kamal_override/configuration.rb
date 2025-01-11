module KamalOverride
  module Configuration

    def proxy_image
      'ccr.ccs.tencentyun.com/kamal/kamal-proxy:v0.8.4'
    end

  end
end

Kamal::Configuration.prepend KamalOverride::Configuration
