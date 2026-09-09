# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'json'

describe 'facts task', if: os[:family] == 'windows' do
  it 'returns facts json' do
    expected = JSON.parse(run_shell('facter --json os').stdout)

    result = run_bolt_task('facts::powershell')
    facts = result.result

    expect(facts).to include('os')
    expect(facts['os']).to include('family', 'name', 'release')
    expect(facts['os']['family']).to eq(expected['os']['family'])
    expect(facts['os']['name']).to eq(expected['os']['name'])
    expect(facts['os']['release']['full']).to eq(expected['os']['release']['full'])
  end
end
