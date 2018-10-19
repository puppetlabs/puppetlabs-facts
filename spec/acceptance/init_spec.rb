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

  operating_system_fact = fact('operatingsystem')
  os_family_fact = fact('osfamily')
  platform = fact('os.name')
  release = fact('os.release.full')

  describe 'puppet facts' do
    let(:script) { File.join(__dir__, '..', '..', 'tasks', 'bash.sh') }

    unless select_hosts(platform: /win/).count > 0 
      it 'bash implementation returns platform' do
        result = run_script(script, 'default', ['platform'], inventory: inventory)
        expect(result[0]['status']).to eq('success')
        expect(result[0]['result']['stdout']).to match(/#{platform}/)
      end

      it 'bash implementation returns release' do
        result = run_script(script, 'default', ['release'], inventory: inventory)
        expect(result[0]['status']).to eq('success')
        expect(result[0]['result']['stdout']).to match(/#{release}/)
      end
    end

    it 'includes legacy and structured facts' do
      result = run_task('facts', 'default', config: config, inventory: inventory)
      expect(result[0]['status']).to eq('success')
      facts = result[0]['result']
      expect(facts).to include('osfamily', 'operatingsystem', 'os')

      expect(facts['osfamily']).to eq(os_family_fact)
      expect(facts['operatingsystem']).to eq(operating_system_fact)

      expect(facts['os']['family']).to eq(os_family_fact)
      expect(facts['os']['name']).to eq(operating_system_fact)
    end
  end
end
