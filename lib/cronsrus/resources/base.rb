module Cronsrus
  module Resources
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def response(options={}, &block)
        options.reverse_merge!({:parse => true, :root => nil})

        response = yield(client.class)
        
        return response if not options[:parse]

        response = response.parsed_response
        return nil unless response
        response = response.send(:[], options[:root]) if options[:root]
        response
      end
    end
  end
end
