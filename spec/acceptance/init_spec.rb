# run a test task
require 'spec_helper_acceptance'

describe 'facts task' do
  operating_system_fact = fact('operatingsystem')
  os_family_fact = fact('osfamily')

  describe 'puppet facts' do
    it 'get a puppet fact' do
      result = run_task(task_name: 'facts', params: 'fact=osfamily', format: 'json')
      expect(result['status']).to eq('success')
      expect(result['result']).to eq('osfamily' => os_family_fact)
      result = run_task(task_name: 'facts', params: 'fact=operatingsystem', format: 'json')
      expect(result['status']).to eq('success')
      expect(result['result']).to eq('operatingsystem' => operating_system_fact)
    end

    it 'get a structured fact' do
      result = run_task(task_name: 'facts', params: 'fact=os', format: 'json')
      expect(result['status']).to eq('success')
      expect(result['result']).to include('os')
      expect(result['result']['os']['family']).to eq(os_family_fact)
      expect(result['result']['os']['name']).to eq(operating_system_fact)
    end

    it 'gets all facts' do
      result = run_task(task_name: 'facts', format: 'json')
      expect(result['status']).to eq('success')
      expect(result['result']).to include('os', 'networking', 'kernel')
    end

    it 'fails cleanly' do
      result = run_task(task_name: 'facts', params: 'fact=--foo', format: 'json')
      expect(result['status']).to eq('failure')
      expect(result['result']['_error']).to eq('kind' => 'facts/failure',
                                               'msg' => "error: unrecognised option '--foo'\n")
    end
  end
end
