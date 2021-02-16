# typed: strict
# frozen_string_literal: true

require 'functions_framework'

FunctionsFramework.on_startup do
  require_relative 'lib/http/webhook'
end

FunctionsFramework.http('webhook') do |request|
  Http::Webhook.new(request).response
end
