# == Route Map
#
#                   Prefix Verb   URI Pattern                    Controller#Action
#               microposts GET    /microposts(.:format)          microposts#index
#                          POST   /microposts(.:format)          microposts#create
#            new_micropost GET    /microposts/new(.:format)      microposts#new
#           edit_micropost GET    /microposts/:id/edit(.:format) microposts#edit
#                micropost GET    /microposts/:id(.:format)      microposts#show
#                          PATCH  /microposts/:id(.:format)      microposts#update
#                          PUT    /microposts/:id(.:format)      microposts#update
#                          DELETE /microposts/:id(.:format)      microposts#destroy
#                    upmin        /admin                         Upmin::Engine
#                     root GET    /                              visitors#index
#         new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
#        user_registration POST   /users(.:format)               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
#                          PATCH  /users(.:format)               devise/registrations#update
#                          PUT    /users(.:format)               devise/registrations#update
#                          DELETE /users(.:format)               devise/registrations#destroy
#                    users GET    /users(.:format)               users#index
#                          POST   /users(.:format)               users#create
#                 new_user GET    /users/new(.:format)           users#new
#                edit_user GET    /users/:id/edit(.:format)      users#edit
#                     user GET    /users/:id(.:format)           users#show
#                          PATCH  /users/:id(.:format)           users#update
#                          PUT    /users/:id(.:format)           users#update
#                          DELETE /users/:id(.:format)           users#destroy
#              rails_admin        /rails_admin                   RailsAdmin::Engine
#             mail_preview        /mail_view                     MailPreview
#                     page GET    /pages/*id                     high_voltage/pages#show
#
# Routes for Upmin::Engine:
#               root GET      /                                 upmin/models#dashboard
#    upmin_dashboard GET      /                                 upmin/models#dashboard
#       upmin_search GET|POST /m/:klass(.:format)               upmin/models#search
#    upmin_new_model GET      /m/:klass/new(.:format)           upmin/models#new
# upmin_create_model POST     /m/:klass/new(.:format)           upmin/models#create
#        upmin_model GET      /m/:klass/i/:id(.:format)         upmin/models#show
#                    PUT      /m/:klass/i/:id(.:format)         upmin/models#update
#       upmin_action POST     /m/:klass/i/:id/:method(.:format) upmin/models#action
#
# Routes for RailsAdmin::Engine:
#   dashboard GET         /                                      rails_admin/main#dashboard
#       index GET|POST    /:model_name(.:format)                 rails_admin/main#index
#         new GET|POST    /:model_name/new(.:format)             rails_admin/main#new
#      export GET|POST    /:model_name/export(.:format)          rails_admin/main#export
# bulk_delete POST|DELETE /:model_name/bulk_delete(.:format)     rails_admin/main#bulk_delete
# bulk_action POST        /:model_name/bulk_action(.:format)     rails_admin/main#bulk_action
#        show GET         /:model_name/:id(.:format)             rails_admin/main#show
#        edit GET|PUT     /:model_name/:id/edit(.:format)        rails_admin/main#edit
#      delete GET|DELETE  /:model_name/:id/delete(.:format)      rails_admin/main#delete
# show_in_app GET         /:model_name/:id/show_in_app(.:format) rails_admin/main#show_in_app
#

Rails.application.routes.draw do
  resources :microposts
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  mount MailPreview => 'mail_view' if Rails.env.development?
end
