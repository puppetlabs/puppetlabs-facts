#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true
require 'open3'
require_relative "../../ruby_task_helper/files/task_helper.rb"

class Facts < TaskHelper
  def task(opts = {})
    facter_version = component_version(:facter)

    facts_command = if facter_version =~ /^[0-2]\./
                      "#{executable(:facter)} -p --json"
                    elsif facter_version =~/^3\./
                      "#{executable(:facter)} -p --json --show-legacy"
                    else
                      # facter 4
                      puppet_version = component_version(:puppet)
                      determine_command_for_facter_4(puppet_version)
                    end

    stdout, stderr, status = Open3.capture3("#{facts_command}")

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
      if File.exist?(exe_path)
        return "\"#{exe_path}\""
      elsif File.exist?(bat_path)
        return "\"#{bat_path}\""
      end
    elsif File.exist?(ruby_path)
      return ruby_path
    end

    # Fall back to PATH lookup if known path does not exist
    type
  end

  def determine_command_for_facter_4(puppet_version)
    if puppet_version =~ /^6\./
      # puppet 6 with facter 4
      "facter --json --show-legacy"
    else
      # puppet 7 with facter 4
      "puppet facts show --show-legacy"
    end
  end

  def component_version(component)
    component = component.to_s
    stdout, _stderr, _status = Open3.capture3("#{executable(component)} --version")

    stdout.strip
  end
end

if __FILE__ == $0
  Facts.run
end
