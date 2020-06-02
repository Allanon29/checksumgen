Rails.application.routes.draw do
  root to: 'home#index'

  post '/generate-checksum', to: 'home#generate_checksum', as: :checksum_generator
  
end
