module KamalOverride
  module BuildClone

    private
    def clone_repo
      info "Cloning repo into build directory `#{KAMAL.config.builder.build_directory}`..."

      FileUtils.mkdir_p KAMAL.config.builder.clone_directory
      KAMAL.builder.clone.each { |step| execute *step }
    end

  end
end

Kamal::Cli::Build::Clone.prepend KamalOverride::BuildClone
