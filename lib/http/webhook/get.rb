# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Http
  class Webhook
    # :nodoc:
    class Get
      extend T::Sig

      VERIFY_TOKEN = ENV.fetch('STRAVA_WEBHOOK_VERIFY_TOKEN', 'abc123')

      attr_reader :request

      sig { params(request: Rack::Request).void }
      def initialize(request)
        @request = request
      end

      sig { returns(T::Array[T.any(Integer, T::Hash[String, String], T::Array[String])]) }
      def response
        return make_response(401, error: 'wrong verify token') if request.params['hub.verify_token'] != VERIFY_TOKEN
        return make_response(422, error: 'empty challenge') if request.params['hub.challenge'].to_s.empty?

        make_response(200, { 'hub.challenge': request.params['hub.challenge'] })
      end

      private

      sig do
        params(status: Integer, body: Hash).returns(T::Array[T.any(Integer, T::Hash[String, String], T::Array[String])])
      end
      def make_response(status, body)
        [
          status,
          { 'Content-Type' => 'application/json' },
          [body.to_json]
        ]
      end
    end
  end
end
