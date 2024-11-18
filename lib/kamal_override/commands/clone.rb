module KamalOverride::Commands
  module Clone

    def clone
      [
        git(:clone, escaped_root, path: config.builder.clone_directory.shellescape),
        git(:submodule, :update, '--init', path: escaped_build_directory)
      ]
    end

  end
end

Kamal::Commands::Builder::Clone.prepend KamalOverride::Commands::Clone
