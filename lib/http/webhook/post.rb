# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Http
  class Webhook
    # :nodoc:
    class Post
      extend T::Sig

      attr_reader :request

      sig { params(request: Rack::Request).void }
      def initialize(request)
        @request = request
      end

      sig { returns(T::Array[T.any(Integer, Hash, String)]) }
      def response
        [200, {}, 'post']
      end
    end
  end
end
