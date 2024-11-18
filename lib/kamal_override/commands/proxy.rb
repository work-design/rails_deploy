module KamalOverride::Commands
  module Proxy

    def run
      docker(
        :run,
        '--name', container_name,
        '--network', 'kamal',
        '--detach',
        '--restart', 'unless-stopped',
        '--volume', 'kamal-proxy-config:/home/kamal-proxy/.config/kamal-proxy',
        '--volume', '~/app/acme:/certs',
        "\$\(#{get_boot_options.join(' ')}\)",
        config.proxy_image
      )
    end

  end
end

Kamal::Commands::Proxy.prepend KamalOverride::Commands::Proxy
