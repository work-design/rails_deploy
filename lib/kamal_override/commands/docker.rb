module KamalOverride::Commands
  module Docker

    private
    def get_docker
      shell \
        any \
          [ :curl, '-fsSL', 'https://work.design/docker' ],
          [ :wget, '-O -', 'https://work.design/docker' ],
          [ :echo, "\"exit 1\"" ]
    end

  end
end

Kamal::Commands::Docker.prepend KamalOverride::Commands::Docker
