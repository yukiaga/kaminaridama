Rails.application.routes.draw do

  namespace :api, {format: 'json'} do
    namespace :v1 do
      get 'lightning/health_check', to: 'lightnings#health_check'
      get 'lightning/:year', to: 'lightnings#year'
      get 'lightning/:year/:month', to:  'lightnings#month'
      get 'lightning/:year/:month/:day', to:  'lightnings#day'
      get 'lightning/:year/:month/:day/:hour', to:  'lightnings#hour'
      get 'lightning/:year/:month/:day/:hour/:minute', to:  'lightnings#minute'
      get 'lightning/:year/:month/:day/:hour/:minute/:second', to:  'lightnings#second'
      get 'lightning/:year/:month/:day/:hour/:minute/:second/:decimal_number', to:  'lightnings#decimal_number'
    end
  end

end
