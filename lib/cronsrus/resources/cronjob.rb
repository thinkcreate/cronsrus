module Cronsrus
  module Resources
    class Cronjob
      #def initialize(client)
      #  @client = client
      #end

      def all
        client.get(cronjob_path)
      end

      def delete(name)
        client.delete(cronjob_path(name))
      end

      def show(name)
        client.get(cronjob_path(name))
      end

      # cronjob e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def update(cronjob)
        name = cronjob['name'] || cronjob[:name]
        client.put(cronjob_path(name), {:body => cronjob})
      end

      # cronjob e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def create(cronjob)
        client.post(cronjob_path, { :body => cronjob })
      end

      def update_or_create(cronjob)
        if show(cronjob).code == 200
          update(cronjob)
        else
          create(cronjob)
        end
      end

      protected
        def client
          self.class.parent.client
        end

        def cronjob_path(id=nil)
          id ? "/cronjobs/#{id}" : "/cronjobs"
        end
    end
  end
end
