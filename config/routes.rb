Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root 'boards#index'

  #members
  post 'create_member' => 'members#create_member', :as => 'create_member'
  # get 'new_member' => 'members#new_member', :as => 'new_member'
  get 'member/:id' => 'members#view_member', :as => 'member'
  get 'edit_member/:id' => 'members#edit_member', :as => 'edit_member'
  post 'update_member' => 'members#update_member', :as => 'update_member' 
  get 'deactivate_member' => 'members#deactivate_member', :as => 'deactivate_member'
  get 'reactivate_member' => 'members#reactivate_member', :as => 'reactivate_member'
  get 'members' => 'members#members', :as => 'members'
  get 'search_members' => 'members#search_members', :as => 'search_members'
  get 'search_group_members' => 'members#search_group_members', :as => 'search_group_members'
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
  get 'delete_join_request' => 'groups#delete_join_request', :as => 'delete_join_request'
  get 'requests/:id' => 'groups#join_requests', :as => 'requests' 
  get 'pending_group_posts/:id' => 'groups#pending_group_posts', :as => 'pending_group_posts'
  get 'group_members/:id' => 'groups#group_members', :as => 'group_members' 
  get 'leave_group' => 'groups#leave_group', :as => 'leave_group'
  get 'group_alerts' => 'groups#group_alerts', :as => 'group_alerts'

#contacts
  post 'create_contact' => 'contacts#create_contact', :as => 'create_contact'
  get 'new_contact' => 'contacts#new_contact', :as => 'new_contact'
  get 'contact/:id' => 'contacts#view_contact', :as => 'contact'
  get 'edit_contact/:id' => 'contacts#edit_contact', :as => 'edit_contact'
  post 'update_contact' => 'contacts#update_contact', :as => 'update_contact'
  get 'delete_contact' => 'contacts#delete_contact', :as => 'delete_contact'

#AdminDashboard
  get 'admin_dashboard' => 'admin_dashboard#index', :as => 'admin_dashboard'
  get 'manage_groups' => 'admin_dashboard#manage_groups', :as => 'manage_groups'
  get 'alerts' => 'admin_dashboard#alerts', :as => 'alerts'
  get 'system_data' => 'admin_dashboard#system_data', :as => 'system_data'

#alerts
  post 'create_alert' => 'alerts#create_alert', :as => 'create_alert'

#system_data
  get 'new_system_data' => 'system_data#new_system_data', :as => 'new_system_data'
  get 'edit_system_data' => 'system_data#edit_system_data', :as => 'edit_system_data'
  post 'create_system_data' => 'system_data#create_system_data', :as => 'create_system_data'
  post 'update_system_data' => 'system_data#update_system_data', :as => 'update_system_data'

#boards
  get 'help' => 'boards#help', :as => 'help'
end
