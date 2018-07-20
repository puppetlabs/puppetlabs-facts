# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'facts task' do
  operating_system_fact = fact('operatingsystem')
  os_family_fact = fact('osfamily')

  describe 'puppet facts' do
    it 'includes legacy and structured facts' do
      result = run_task(task_name: 'facts', format: 'json')
      expect(result['status']).to eq('success')
      facts = result['result']
      expect(facts).to include('osfamily', 'operatingsystem', 'os')

      expect(facts['osfamily']).to eq(os_family_fact)
      expect(facts['operatingsystem']).to eq(operating_system_fact)

      expect(facts['os']['family']).to eq(os_family_fact)
      expect(facts['os']['name']).to eq(operating_system_fact)
    end
  end
end
