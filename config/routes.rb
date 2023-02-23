Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root to:"homes#top"
    resources :contacts, only: [:new, :create] do
      collection do
        post :confirm
        get :complete
      end
    end
    resources :impressions, only:[:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :favorites, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
    end
    get 'search', to: 'impressions#search', as: 'search'
    resources :customers, only:[:show, :edit, :update] do
      member do
        get :favorites
      end
    end
    # いいねランキング画面
    get 'ranks/rank'
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
  end

  namespace :admin do
    resources :customers, only:[:index, :show, :destroy]
    resources :impressions, only:[:index, :show, :destroy] do
      resources :comments, only:[:destroy]
    end
    resources :fields, only:[:index, :create, :edit, :update, :destroy]
  end
end