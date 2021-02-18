# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'webhook/get'
require_relative 'webhook/post'

module Http
  # :nodoc:
  class Webhook
    extend T::Sig

    attr_reader :request

    sig { params(request: Rack::Request).void }
    def initialize(request)
      @request = request
    end

    sig { returns(T::Array[T.any(Integer, Hash, String)]) }
    def response
      responder.new(request).response
    end

    private

    def responder
      case request.request_method
      when 'GET'
        Webhook::Get
      when 'POST'
        Webhook::Post
      end
    end
  end
end
