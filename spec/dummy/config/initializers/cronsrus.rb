unless Rails.env.production?
  Cronsrus::Client.new(Cronsrus.config).tap do |client|
    Cronsrus.config['cronjobs'].each do |name, data|
      data.merge!({'name' => name})
      data.merge!({'timezone' => Time.zone.name}) unless data['timezone']
      client.cronjobs.update_or_create(data)
    end
  end
end
