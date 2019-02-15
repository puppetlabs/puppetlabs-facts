# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'beaker-task_helper/inventory'
require 'bolt_spec/run'

describe 'facts task' do
  include Beaker::TaskHelper::Inventory
  include BoltSpec::Run

  def module_path
    RSpec.configuration.module_path
  end

  def config
    { 'modulepath' => module_path }
  end

  def inventory
    hosts_to_inventory
  end

  os_family_fact = fact('osfamily')
  platform = fact('os.name') == 'OracleLinux' ? 'RedHat' : fact('os.name')
  release = fact('os.release.full')

  describe 'bash facts implementation', unless: fact_on(default, 'osfamily') == 'windows' do
    let(:script) { File.join(__dir__, '..', '..', 'tasks', 'bash.sh') }

    it 'returns platform when invoked with platform parameter' do
      result = run_script(script, 'default', ['platform'], inventory: inventory)
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['stdout']).to match(/#{platform}/)
    end

    it 'returns release when invoked with release parameter' do
      result = run_script(script, 'default', ['release'], inventory: inventory)
      expect(result[0]['status']).to eq('success')
      expect(release).to match(/#{result[0]['result']['stdout'].strip}/)
    end

    it 'returns facts json' do
      result = run_task('facts::bash', 'default', {}, config: config, inventory: inventory)
      facts = result[0]['result']
      expect(facts).to include('os')
      expect(facts['os']). to include('family', 'name', 'release')
      expect(facts['os']['family']).to match(/#{os_family_fact}/)
      expect(facts['os']['name']).to match(/#{platform}/)
      expect(release).to match(/#{facts['os']['release']['full']}/)
    end
  end
end
