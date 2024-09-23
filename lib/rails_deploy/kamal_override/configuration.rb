module KamalOverride::Configuration

  private
  def proxy_image
    'ccr.ccs.tencentyun.com/work-design/kamal-proxy:latest'
  end

end

Kamal::Configuration.prepend KamalOverride::Configuration
