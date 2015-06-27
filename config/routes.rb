Rails.application.routes.draw do
  devise_for :users
  root 'boards#index'

  #members
  post 'create_member' => 'members#create_member', :as => 'create_member'
  get 'new_member' => 'members#new_member', :as => 'new_member'
  get 'member/:id' => 'members#view_member', :as => 'member'
  get 'edit_member/:id' => 'members#edit_member', :as => 'edit_member'
  post 'update_member' => 'members#update_member', :as => 'update_member'
  # get 'deactivate_member/:id' => 'members#deactivate_member', :as => 'deactivate_member'
  get 'members' => 'members#members', :as => 'members'
  get 'search_members' => 'members#search_members', :as => 'search_members'
  # get 'autosuggest_member' => 'members#autosuggest_member', :as => 'autosuggest_member'

#posts
  post 'create_post' => 'posts#create_post', :as => 'create_post'
  get 'new_post' => 'posts#new_post', :as => 'new_post'
  get 'post/:id' => 'posts#view_post', :as => 'post'
  get 'edit_post/:id' => 'posts#edit_post', :as => 'edit_post'
  post 'update_post' => 'posts#update_post', :as => 'update_post'
  # get 'deactivate_member/:id' => 'members#deactivate_member', :as => 'deactivate_member'
  get 'posts' => 'posts#posts', :as => 'posts'
end
