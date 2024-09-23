module KamalOverride
  module Configuration

    private
    def proxy_image
      'ccr.ccs.tencentyun.com/work-design/kamal-proxy:latest'
    end

  end
end

Kamal::Configuration.prepend KamalOverride::Configuration
