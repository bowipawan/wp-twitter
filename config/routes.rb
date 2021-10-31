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
end
