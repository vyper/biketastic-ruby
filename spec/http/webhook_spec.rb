# typed: false
# frozen_string_literal: true

require 'rspec'
require 'functions_framework/testing'

describe 'Http::Webhook' do
  include FunctionsFramework::Testing

  it 'GET /' do
    load_temporary 'app.rb' do
      request = make_get_request 'https://example.com/webhook?hub.verify_token=abc123&hub.challenge=15f7d1a91c1f40f8a748fd134752feb3&hub.mode=subscribe'
      response = call_http 'webhook', request

      expect(response).to be_successful
    end
  end

  it 'POST /' do
    load_temporary 'app.rb' do
      request = make_post_request 'https://example.com/webhook', '{"name":"Ruby"}', ['Content-Type: application/json']
      response = call_http 'webhook', request

      expect(response).to be_successful
    end
  end
end
