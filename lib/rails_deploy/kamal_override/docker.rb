module KamalOverride::Docker

  private
  def get_docker
    shell \
      any \
        [ :curl, '-fsSL', 'https://meal.design/docker' ],
        [ :wget, '-O -', 'https://meal.design/docker' ],
        [ :echo, "\"exit 1\"" ]
  end
end

Kamal::Commands::Docker.prepend KamalOverride::Docker
