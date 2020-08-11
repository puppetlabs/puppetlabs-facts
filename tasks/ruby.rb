#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true
require 'open3'
require_relative "../../ruby_task_helper/files/task_helper.rb"

class Facts < TaskHelper
  def facter_executable
    install_path = File.join(File.dirname(RbConfig.ruby), 'facter')

    # Fall back to PATH lookup if puppet-agent isn't installed
    if File.exist?(install_path)
      # Paths with spaces must be quoted on Windows, which means slashes need escaping
      Gem.win_platform? ? "\"#{install_path}\"" : install_path
    else
      'facter'
    end
  end

  def task(opts = {})
    # Delegate to facter
    stdout, stderr, status = Open3.capture3("#{facter_executable} -v")

    if stdout =~ /^[0-2]\./
      exec("#{facter_executable} -p --json")
    else
      exec("#{facter_executable} -p --json --show-legacy")
    end
  end
end

if __FILE__ == $0
  Facts.run
end
