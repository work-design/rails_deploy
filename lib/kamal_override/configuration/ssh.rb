module KamalOverride::Configuration
  module Ssh

    private
    def logger
      Logger.new("log/#{Thread.current.native_thread_id}_kamal.log")
    end

  end
end

Kamal::Configuration::Ssh.prepend KamalOverride::Configuration::Ssh