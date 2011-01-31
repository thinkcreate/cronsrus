module Cronsrus
  module Resources
    class Cronjob
      #def initialize(client)
      #  @client = client
      #end

      def all(options={})
        options.reverse_merge!({:root => 'cronjobs'})
        response(client.get(cronjob_path), options)
      end

      def delete(name, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(client.delete(cronjob_path(name)), options)
      end

      def show(name, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(client.get(cronjob_path(name)), options)
      end

      # cronjob e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def update(cronjob, options={})
        options.reverse_merge!({:root => 'cronjob'})
        # TODO support renaming
        name = cronjob['name'] || cronjob[:name]
        response(client.put(cronjob_path(name), {:body => cronjob}), options)
      end

      # cronjob e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def create(cronjob, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(client.post(cronjob_path, { :body => cronjob }), options)
      end

      def update_or_create(cronjob, options={})
        name = (cronjob['name'] || cronjob[:name])
        if show(name, :parsed => false).code == 200
          update(cronjob, options)
        else
          create(cronjob, options)
        end
      end

      protected
        # 
        def response(response, options={})
          options.reverse_merge!({:parsed => true, :root => nil})
          return response if not options[:parsed]

          response = response.parsed_response
          response = response.send(:[], options[:root]) if options[:root]
          response
        end

        #def request(method, method_options, options)
        #  response_options = options.delete(:response)
        #  client.send(method, options)
        #end

        def client
          self.class.parent.client
        end

        def cronjob_path(id=nil)
          id ? "/cronjobs/#{id}" : "/cronjobs"
        end
    end
  end
end
