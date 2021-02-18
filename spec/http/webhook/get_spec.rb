# typed: false
# frozen_string_literal: true

require 'rspec'
require 'functions_framework/testing'

require './lib/http/webhook/get'

describe Http::Webhook::Get do
  include FunctionsFramework::Testing

  subject(:responder) { described_class.new(request) }

  let(:request) { make_get_request 'https://example.com/webhook' }

  it { expect(responder.response.first).to eq 200 }
  it { expect(responder.response.last).to eq 'get' }
end
