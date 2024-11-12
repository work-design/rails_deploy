module KamalOverride
  module Clone

    def clone
      git :clone, escaped_root, '--recurse-submodules=vendor/engine', '--shallow-submodules', path: config.builder.clone_directory.shellescape
    end

  end
end

Kamal::Commands::Builder::Clone.prepend KamalOverride::Clone
