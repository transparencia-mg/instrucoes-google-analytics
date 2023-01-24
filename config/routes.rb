Rails.application.routes.draw do
  get "importations/new", to: "importations#new" #Importação arquivo .csv
  post "importations/import", to: "importations#import" #Importação arquivo .csv
  get "export", to: "importations#export", :defaults => { :format => 'csv' } #Importação arquivo .csv
  devise_for :users
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
end