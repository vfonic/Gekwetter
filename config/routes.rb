# == Route Map
#
#                   Prefix Verb   URI Pattern                           Controller#Action
#              rails_admin        /rails_admin                          RailsAdmin::Engine
#                   api_v1 GET    /api/v1/:username/followers(.:format) api/v1/relationships#followers {:format=>"json"}
#                          GET    /api/v1/:username/following(.:format) api/v1/relationships#following {:format=>"json"}
#                          GET    /api/v1/:username(.:format)           api/v1/users#show {:format=>"json"}
#                          GET    /api/v1(.:format)                     redirect(301, /api/v1/api.html) {:format=>"json"}
#                      api GET    /api(.:format)                        redirect(301, /api/v1) {:format=>"json"}
#       authenticated_root GET    /                                     microposts#timeline
#                     root GET    /                                     visitors#index
#         new_user_session GET    /users/sign_in(.:format)              devise/sessions#new
#             user_session POST   /users/sign_in(.:format)              devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)             devise/sessions#destroy
#            user_password POST   /users/password(.:format)             devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)         devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)        devise/passwords#edit
#                          PATCH  /users/password(.:format)             devise/passwords#update
#                          PUT    /users/password(.:format)             devise/passwords#update
# cancel_user_registration GET    /user/cancel(.:format)                devise/registrations#cancel
#        user_registration POST   /user(.:format)                       devise/registrations#create
#    new_user_registration GET    /user/sign_up(.:format)               devise/registrations#new
#   edit_user_registration GET    /user/edit(.:format)                  devise/registrations#edit
#                          PATCH  /user(.:format)                       devise/registrations#update
#                          PUT    /user(.:format)                       devise/registrations#update
#                          DELETE /user(.:format)                       devise/registrations#destroy
#              follow_user POST   /:username/follow(.:format)           relationships#create
#            unfollow_user POST   /:username/unfollow(.:format)         relationships#destroy
#                    users GET    /users(.:format)                      users#index
#          user_microposts POST   /:user_id/microposts(.:format)        microposts#create
#           user_micropost DELETE /:user_id/microposts/:id(.:format)    microposts#destroy
#           following_user GET    /:id/following(.:format)              users#following
#           followers_user GET    /:id/followers(.:format)              users#followers
#                          POST   /                                     users#create
#                 new_user GET    /new(.:format)                        users#new
#                edit_user GET    /:id/edit(.:format)                   users#edit
#                     user GET    /:id(.:format)                        users#show
#                          PATCH  /:id(.:format)                        users#update
#                          PUT    /:id(.:format)                        users#update
#                          DELETE /:id(.:format)                        users#destroy
#                          GET    /:any(.:format)                       redirect(301, subdomain: , path: /%{any}) {:any=>/.*/, :subdomain=>"www"}
#                     page GET    /pages/*id                            high_voltage/pages#show
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
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get ':username/followers' => 'relationships#followers'
      get ':username/following' => 'relationships#following'
      get ':username' => 'users#show'
      get '', to: redirect('/api/v1/api.html')
    end
    get '', to: redirect('/api/v1')
  end

  authenticated :user do
    root to: 'microposts#timeline', as: :authenticated_root
  end
  root to: 'visitors#index'

  devise_for :users, skip: :registrations
  devise_for :user, only: :registrations do
    resource :registration, only: [:new, :create], controller: 'devise/registrations'
  end

  post ':username/follow', to: 'relationships#create', as: :follow_user
  post ':username/unfollow', to: 'relationships#destroy', as: :unfollow_user

  resources :users, only: :index
  resources :users, except: :index, path: '' do
    resources :microposts, only: [:destroy, :create]
    member do
      get :following, :followers
    end
  end

  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end
end
