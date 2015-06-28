Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
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
  get 'verify_member' => 'members#verify_member', :as => 'verify_member' 
  get 'search_members_for_form' => 'members#search_members_for_form', :as => 'search_members_for_form'
  # get 'autosuggest_member' => 'members#autosuggest_member', :as => 'autosuggest_member'

#posts
  post 'create_post' => 'posts#create_post', :as => 'create_post'
  get 'new_post' => 'posts#new_post', :as => 'new_post'
  get 'post/:id' => 'posts#view_post', :as => 'post'
  get 'edit_post/:id' => 'posts#edit_post', :as => 'edit_post'
  post 'update_post' => 'posts#update_post', :as => 'update_post'
  # get 'deactivate_member/:id' => 'members#deactivate_member', :as => 'deactivate_member'
  get 'posts' => 'posts#posts', :as => 'posts'
  get 'approve_post' => 'posts#approve_post', :as => 'approve_post'

#groups
  post 'create_group' => 'groups#create_group', :as => 'create_group'
  get 'new_group' => 'groups#new_group', :as => 'new_group'
  get 'group/:id' => 'groups#view_group', :as => 'group'
  get 'edit_group/:id' => 'groups#edit_group', :as => 'edit_group'
  post 'update_group' => 'groups#update_group', :as => 'update_group'
  get 'groups' => 'groups#groups', :as => 'groups'
  get 'request_join_group' => 'groups#request_join_group', :as => 'request_join_group'
  get 'approve_join_request' => 'groups#approve_join_request', :as => 'approve_join_request'
  get 'requests/:id' => 'groups#join_requests', :as => 'requests' 


#AdminDashboard
  get 'admin_dashboard' => 'admin_dashboard#index', :as => 'admin_dashboard'
  get 'manage_groups' => 'admin_dashboard#manage_groups', :as => 'manage_groups'
end
