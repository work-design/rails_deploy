module KamalOverride
  module Configuration

    def proxy_image
      'ccr.ccs.tencentyun.com/work-design/kamal-proxy:v0.4.0'
    end

  end
end

Kamal::Configuration.prepend KamalOverride::Configuration
