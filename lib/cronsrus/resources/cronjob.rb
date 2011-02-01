module Cronsrus
  module Resources
    class Cronjob < Base
      def all(options={})
        options.reverse_merge!({:root => 'cronjobs'})
        response(client.class.get(cronjob_path), options)
      end

      def delete(name, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(client.class.delete(cronjob_path(name)), options)
      end

      def show(name, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(client.class.get(cronjob_path(name)), options)
      end

      # cronjob e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def update(cronjob, options={})
        options.reverse_merge!({:root => 'cronjob'})
        # TODO support renaming
        name = cronjob['name'] || cronjob[:name]
        response(client.class.put(cronjob_path(name), {:body => cronjob}), options)
      end

      # cronjob e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def create(cronjob, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(client.class.post(cronjob_path, { :body => cronjob }), options)
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
        def cronjob_path(id=nil)
          id ? "/cronjobs/#{id}" : "/cronjobs"
        end
    end
  end
end
