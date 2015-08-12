Rails.application.routes.draw do
  get "users" => "user#index"
  get "users/:name/groups" => "user#groups"
  get "users/:name/attendance" => "user#attendance"

  post "users" => "user#create"
  post "users/:user_name/log_location" => "user#log_location"
  post "authenticate" => "user#authenticate"

  get "groups/:name/users" => "group#users"
  get "groups" => "group#index"
  
  post "groups" => "group#create"

  post "groups/:group_name/add_user" => "group#add_user"
  post "groups/:group_name/remove_user" => "group#remove_user"
end
