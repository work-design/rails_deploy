module KamalOverride::Commands
  module Docker

    private
    def get_docker
      shell \
        any \
          [ :curl, '-fsSL', 'https://yicanzhiji.com/docker' ],
          [ :wget, '-O -', 'https://yicanzhiji.com/docker' ],
          [ :echo, "\"exit 1\"" ]
    end

  end
end

Kamal::Commands::Docker.prepend KamalOverride::Commands::Docker
