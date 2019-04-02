Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "customers#index", as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get  	 "/logins", 					              to: "logins#index"
  get  	 "/logins/:customer_id", 			      to: "logins#show"
  post 	 "/logins/create", 		              to: "logins#create"
  delete "/logins/destroy/:login_id", 	    to: "logins#destroy",     as: :logins_destroy
  delete "/customers/destroy/:customer_id", to: "customers#destroy",  as: :customers_destroy
  get  	 "/transactions/:account_id",       to: "transactions#index", as: :transactions
  get 	 "/accounts/:login_id",             to: "accounts#index",     as: :accounts
  get 	 "/customers", 				              to: "customers#index"
  put    "/logins/refresh/:login_id",       to: "logins#refresh",     as: :logins_refresh
  put    "/logins/reconnect/:login_id",     to: "logins#reconnect",   as: :logins_reconnect

  # resources :logins, only: %i(create destroy show index)

  # resources :customers, only: :index do
  # 	resources :logins, only: :index do
  # 		resources :accounts, only: :index do
  #       resources :transactions, only: :index
  #     end
  # 	end
 	# end
end
