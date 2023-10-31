# frozen_string_literal: true

require 'open3'
require 'optparse'
require 'pathname'
require 'logger'

module Deploy
  MOVED_DIRS = [
    'log',
    'tmp'
  ].freeze
  SHARED_DIRS = [
    'public/assets',
    'public/fonts',
    'vendor/bundle'
  ].freeze
  INIT_DIRS = [
    'tmp/sockets',
    'tmp/pids',
    'config/credentials'
  ].freeze
  SHARED_FILES = [
    'config/credentials/production.key'
  ].freeze
  extend self

  def restart
    exec_cmd('bundle exec pumactl restart')
  end

  def github_hmac(data)
    OpenSSL::HMAC.hexdigest('sha1', RailsCom.config.github_hmac_key, data)
  end

  def init(root: Pathname.pwd, shared: Pathname.pwd.join('../shared'))
    dirs = (MOVED_DIRS + SHARED_DIRS + INIT_DIRS).map { |dir| shared.join(dir) }
    FileUtils.mkdir_p dirs, verbose: true

    files = SHARED_FILES.map { |file| shared.join(file) }
    FileUtils.touch files, verbose: true

    cmds = []
    cmds << 'bundle config set --local deployment true'
    cmds << 'bundle config set --local path vendor/bundle'
    cmds << 'bundle config set --local without development test'
    cmds += MOVED_DIRS.map do |path|
      "rm -rf #{root.join(path)}"
    end
    cmds += (MOVED_DIRS + SHARED_DIRS).map do |path|
      "ln -Tsfv #{shared.join(path)} #{root.join(path)}"
    end
    cmds += SHARED_FILES.map do |path|
      "ln -Tsfv #{shared.join(path)} #{root.join(path)}"
    end
    cmds.each do |cmd|
      exec_cmd(cmd)
    end
  end

  def exec_cmds(env = 'production', added_cmds: [])
    start_at = Time.now
    logger.info "Deploy started at #{start_at}"
    cmds = [
      'whoami',
      'git pull',#  --recurse-submodules
      'bundle install'
    ]
    cmds << "RAILS_ENV=#{env} bundle exec rake db:migrate"
    cmds << 'bundle exec pumactl restart'
    cmds += Array(added_cmds)
    cmds.each do |cmd|
      exec_cmd(cmd)
    end
    finish_at = Time.now
    logger.info "Deploy finished at #{finish_at}, used: #{(finish_at - start_at).round(2)}s"
  end

  def exec_cmd(cmd)
    Open3.popen2e(cmd) do |_, output, thread|
      logger.info "\e[35m  #{cmd} (PID: #{thread.pid})  \e[0m"
      output.each_line do |line|
        logger.info "  #{line.chomp}"
      end
      puts "\n"
    end
  end

  def logger
    if defined? Rails
      Rails.logger
    else
      Logger.new $stdout
    end
  end

end

options = { env: 'production' }
OptionParser.new do |opts|
  opts.on('-e ENV') do |v|
    options[:env] = v
  end
  opts.on('-C') do |v|
    puts "--------->#{v}"
  end
end.parse!
