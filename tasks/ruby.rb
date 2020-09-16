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
      facter_args = "-p --json"
    else
      facter_args = "-p --json --show-legacy"
    end

    stdout, stderr, status = Open3.capture3("#{facter_executable} #{facter_args}")

    result = JSON.parse(stdout)

    if status.exitstatus != 0
      result[:_error] = { msg: stderr }
    end

    return result
  end
end

if __FILE__ == $0
  Facts.run
end
