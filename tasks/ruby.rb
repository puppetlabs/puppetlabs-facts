#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true
require 'open3'
require_relative "../../ruby_task_helper/files/task_helper.rb"

class Facts < TaskHelper
  def facter_executable
    exe_path = File.join(File.dirname(RbConfig.ruby), 'facter.exe')
    bat_path = File.join(File.dirname(RbConfig.ruby), 'facter.bat')
    ruby_path = File.join(File.dirname(RbConfig.ruby), 'facter')

    if Gem.win_platform?
      if File.exist?(exe_path)
        return "\"#{exe_path}\""
      elsif File.exist?(bat_path)
        return "\"#{bat_path}\""
      end
    elsif File.exist?(ruby_path)
      return ruby_path
    end

    # Fall back to PATH lookup if known path does not exist
    'facter'
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
