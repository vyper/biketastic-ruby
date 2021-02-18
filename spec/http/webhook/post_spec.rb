# typed: false
# frozen_string_literal: true

require 'rspec'
require 'functions_framework/testing'

require './lib/http/webhook/post'

describe Http::Webhook::Post do
  include FunctionsFramework::Testing

  subject(:responder) { described_class.new(request) }

  let(:request) do
    make_post_request 'https://example.com/webhook', '{"name":"Ruby"}', ['Content-Type: application/json']
  end

  it { expect(responder.response.first).to eq 200 }
  it { expect(responder.response.last).to eq 'post' }
end
