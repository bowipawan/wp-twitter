Rails.application.routes.draw do
  get 'main', to: "main#main"
  post 'login', to: "main#login"
  get 'register', to: "main#register"
  post 'register', to: "main#create_user"
  get 'profile/:name', to: "users#profile", as: 'user'
  get 'logout', to: "main#logout"
  get 'feed', to: "users#feed", as: 'feed'
  get 'post', to: "posts#post", as: 'post'
  post 'create_post', to: "posts#create_post"
  get 'follow/:name', to: 'users#follow', as: 'follow'
  get 'unfollow/:name', to: 'users#unfollow', as: 'unfollow'
  post 'following/:name', to: 'users#following', as: 'following'
  post 'liking/:post', to: 'users#liking', as: 'liking'
  get 'liked_user', to: 'posts#liked_user', as: 'liked_user'
  # resources user
  get '/users(.:format)', to: 'users#index', as: 'users'
  get '/users/new(.:format)', to: 'users#new', as: 'new_user'
  get '/user/:id(.:format)', to: 'users#show', as: 'show_user'
  get '/user/:id/edit(.:format)', to: 'users#edit', as: 'edit_user'
  patch '/users/:id(.:format)', to: 'users#update'
  put '/users/:id(.:format)', to: 'users#update'
  delete '/users/:id(.:format)', to: 'users#destroy', as: 'destroy_user'
  # resources post
  get '/posts(.:format)', to: 'posts#index', as: 'posts'
  get '/posts/new(.:format)', to: 'posts#new', as: 'new_post'
  get '/posts/:id(.:format)', to: 'posts#show', as: 'show_post'
  get '/posts/:id/edit(.:format)', to: 'posts#edit', as: 'edit_post'
  patch '/posts/:id(.:format)', to: 'posts#update'
  put '/posts/:id(.:format)', to: 'posts#update'
  delete '/posts/:id(.:format)', to: 'posts#destroy', as: 'destroy_post'
  # resources like
  get '/likes(.:format)', to: 'likes#index', as: 'likes'
  get '/likes/new(.:format)', to: 'likes#new', as: 'new_like'
  get '/likes/:id(.:format)', to: 'likes#show', as: 'show_like'
  get '/likes/:id/edit(.:format)', to: 'likes#edit', as: 'edit_like'
  patch '/likes/:id(.:format)', to: 'likes#update'
  put '/likes/:id(.:format)', to: 'likes#update'
  delete '/likes/:id(.:format)', to: 'likes#destroy', as: 'destroy_like'

end
