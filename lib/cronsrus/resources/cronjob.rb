module Cronsrus
  module Resources
    class Cronjob < Base
      # for these operations:
      # all, delete, show, update, create, update_or_create
      #
      # return an instance or collection of hashes with data when successfull
      # return nil otherwise
      # accepted options:
      # - parse: default true. Pass false if you want the raw response
      # - root: what part to return of data

      def all(options={})
        options.reverse_merge!({:root => 'cronjobs'})
        response(options) do |r|
          r.get(cronjob_path)
        end
      end

      def delete(id, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(options) do |r|
          r.delete(cronjob_path(id))
        end
      end

      def show(id, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(options) do |r|
          r.get(cronjob_path(id))
        end
      end

      # data e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def update(id, data, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(options) do |r|
          r.put(cronjob_path(id), {:body => data})
        end
      end

      # data e.g. {:name => 'hourly', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      def create(data, options={})
        options.reverse_merge!({:root => 'cronjob'})
        response(options) do |r|
          r.post(cronjob_path, {:body => data})
        end
      end

      def update_or_create(id, data, options={})
        if show(id)
          update(id, data, options)
        else
          create(data, options)
        end
      end

      protected
        def cronjob_path(id=nil)
          id ? "/cronjobs/#{id}" : "/cronjobs"
        end
    end
  end
end
