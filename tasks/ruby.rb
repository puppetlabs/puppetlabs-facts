#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true

require 'open3'
require_relative '../../ruby_task_helper/files/task_helper.rb'

# Retrieve facts from the system
class Facts < TaskHelper
  def task(_opts = {})
    facter_executable = executable(:facter)
    facter_version = component_version(facter_executable)

    facts_command = if %r{^3\.}.match?(facter_version)
                      "#{facter_executable} -p --json --show-legacy"
                    else
                      # facter 4
                      determine_command_for_facter_4(facter_executable)
                    end

    stdout, stderr, status = Open3.capture3(facts_command.to_s)

    result = JSON.parse(stdout)

    if status.exitstatus != 0
      result[:_error] = { msg: stderr }
    end

    result
  end

  private

  # type can be :facter or :puppet
  def executable(type)
    type = type.to_s
    exe_path = File.join(File.dirname(RbConfig.ruby), "#{type}.exe")
    bat_path = File.join(File.dirname(RbConfig.ruby), "#{type}.bat")
    ruby_path = File.join(File.dirname(RbConfig.ruby), type)

    if Gem.win_platform?
      if File.exist?(bat_path)
        return "\"#{bat_path}\""
      elsif File.exist?(exe_path)
        return "\"#{exe_path}\""
      end
    elsif File.exist?(ruby_path)
      return ruby_path
    end

    # Fall back to PATH lookup if known path does not exist
    type
  end

  def determine_command_for_facter_4(facter_executable)
    puppet_executable = executable(:puppet)
    puppet_version = component_version(puppet_executable)
    # puppet 7 with facter 4
    "#{puppet_executable} facts show --show-legacy --render-as json"
    
  end

  def component_version(exec)
    stdout, _stderr, _status = Open3.capture3("#{exec} --version")

    stdout.strip
  end
end

if __FILE__ == $PROGRAM_NAME
  Facts.run
end
