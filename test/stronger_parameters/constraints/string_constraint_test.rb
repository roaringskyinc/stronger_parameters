# frozen_string_literal: true
require_relative '../../test_helper'

SingleCov.covered! uncovered: 1

describe 'string parameter constraints' do
  subject { ActionController::Parameters.string }

  permits 'abc'

  rejects 123
  rejects Date.today
  rejects Time.now
  rejects nil
  rejects "\xA1".dup.force_encoding('UTF-8')

  it 'rejects strings that are too long' do
    assert_rejects(:value) { params(value: '123').permit(value: ActionController::Parameters.string(max_length: 2)) }
  end

  it 'rejects strings that are too short' do
    assert_rejects(:value) { params(value: '1234').permit(value: ActionController::Parameters.string(min_length: 5)) }
  end
end
