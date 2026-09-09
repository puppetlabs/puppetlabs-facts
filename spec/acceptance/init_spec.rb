# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'json'

describe 'facts task' do
  it 'includes legacy and structured facts' do
    expected = JSON.parse(run_shell('facter --json os osfamily operatingsystem').stdout)

    result = run_bolt_task('facts')
    facts = result.result

    expect(facts).to include('osfamily', 'operatingsystem', 'os')
    expect(facts['osfamily']).to eq(expected['osfamily'])
    expect(facts['operatingsystem']).to eq(expected['operatingsystem'])
    expect(facts['os']['family']).to eq(expected['os']['family'])
    expect(facts['os']['release']['full']).to eq(expected['os']['release']['full'])
  end
end
