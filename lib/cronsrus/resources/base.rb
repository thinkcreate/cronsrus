module Cronsrus
  module Resources
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def response(response, options={})
        options.reverse_merge!({:parsed => true, :root => nil})
        return response if not options[:parsed]

        response = response.parsed_response
        response = response.send(:[], options[:root]) if options[:root]
        response
      end
    end
  end
end
