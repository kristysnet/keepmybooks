Keepmybooks::Application.routes.draw do

  resources :accounts do
    resources :transactions
  end
  resources :categories

end
