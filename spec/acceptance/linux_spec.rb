# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'json'

describe 'facts task', unless: os[:family] == 'windows' do
  let(:script) { File.join(__dir__, '..', '..', 'tasks', 'bash.sh') }

  it 'returns platform when invoked with platform parameter' do
    expected = JSON.parse(run_shell('facter --json os').stdout)

    result = bolt_run_script(script, arguments: ['platform'])

    expect(result.exit_code).to eq(0)
    expect(result.stdout.strip).to eq(expected['os']['name'])
  end

  it 'returns release when invoked with release parameter' do
    expected = JSON.parse(run_shell('facter --json os').stdout)

    result = bolt_run_script(script, arguments: ['release'])

    expect(result.exit_code).to eq(0)
    expect(expected['os']['release']['full']).to match(%r{#{Regexp.escape(result.stdout.strip)}})
  end

  it 'returns facts json' do
    expected = JSON.parse(run_shell('facter --json os osfamily').stdout)

    result = run_bolt_task('facts::bash')
    facts = result.result

    expect(facts).to include('os')
    expect(facts['os']).to include('distro', 'family', 'name', 'release')
    expect(facts['os']['distro']).to include('codename')
    expect(facts['os']['family']).to eq(expected['os']['family'])
    expect(facts['os']['name']).to eq(expected['os']['name'])
    expect(facts['os']['release']['full']).to eq(expected['os']['release']['full'])
  end
end
