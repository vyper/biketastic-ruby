# typed: false
# frozen_string_literal: true

require 'rspec'
require 'functions_framework/testing'

require './lib/http/webhook/get'

describe Http::Webhook::Get do
  include FunctionsFramework::Testing

  subject(:response) { described_class.new(request).response }

  let(:url) { 'https://example.com/webhook?hub.verify_token=abc123&hub.challenge=15f7d1a91c1f&hub.mode=subscribe' }
  let(:request) do
    make_get_request url
  end

  it { expect(response[0]).to eq 200 }
  it { expect(response[1]).to include 'Content-Type' => 'application/json' }
  it { expect(response[2]).to include({ 'hub.challenge': '15f7d1a91c1f' }.to_json) }

  context 'when verify token is invalid' do
    let(:url) { 'https://example.com/webhook?hub.verify_token=invalid&hub.challenge=15f7d1a91c1f&hub.mode=subscribe' }

    it { expect(response[0]).to eq 401 }
    it { expect(response[2]).to include({ error: 'wrong verify token' }.to_json) }
  end

  context 'when challenge is empty' do
    let(:url) { 'https://example.com/webhook?hub.verify_token=abc123&hub.challenge=&hub.mode=subscribe' }

    it { expect(response[0]).to eq 422 }
    it { expect(response[2]).to include({ error: 'empty challenge' }.to_json) }
  end
end
