Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '192.168.1.53:8081/' # later change to the domain of the frontend app
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: [:Authorization]
  end
end
