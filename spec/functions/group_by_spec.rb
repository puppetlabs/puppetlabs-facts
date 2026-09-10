# frozen_string_literal: true

require 'spec_helper'

describe 'facts::group_by' do
  it 'delegates to the native group_by function' do
    collection = double('Puppet::Pops::Types::Iterable').extend(Puppet::Pops::Types::Iterable)
    return_value = {}

    verifier = double('verifier')
    token = double('token')

    expect(collection).to receive(:group_by).with(no_args).and_yield(token).and_return(return_value)
    # this is to verify that the block passed to the 'facts::group_by' function
    # is yielded to from the stubbed group_by method
    expect(verifier).to receive(:verify).with(token)

    expect(subject).to run.with_params(collection).with_lambda(&(proc do |t|
      verifier.verify(t)
    end)).and_return(return_value)
  end
end
