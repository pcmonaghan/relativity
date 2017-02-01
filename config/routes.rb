Rails.application.routes.draw do

  get 'reviews/new'

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'comparisons#compare', as: :authenticated_root
    end

    unauthenticated do
      root :to => 'users/sessions#new', as: :unauthenticated_root
    end
  end
  get 'static_pages/home', to: 'static_pages#home'
  get 'comparisons', to: 'comparisons#compare'
  post 'comparisons', to: 'comparisons#new_review'
  get 'users/:id', to: 'users#show', as: :user
  post '/:integration_name/update-forms', to: 'webhooks#recieve', as: :receive_webhooks
  constraints subdomain: "hooks" do
    post '/:integration_name' => 'webhooks#receive' #as: :receive_webhooks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
