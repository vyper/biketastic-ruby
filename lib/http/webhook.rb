# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Http
  # :nodoc:
  class Webhook
    extend T::Sig

    attr_reader :request

    sig { params(request: Rack::Request).void }
    def initialize(request)
      @request = request
    end

    sig { returns(String) }
    def response
      "Received request url: #{request.url}\n"
    end
  end
end
