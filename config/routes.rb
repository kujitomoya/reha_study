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
    resources :impressions, only:[:index, :new, :create, :show, :edit, :update, :destroy]
    resources :comments, only:[:create, :destroy]
    resources :favorites, only:[:create, :destroy]
    resources :customers, only:[:show, :edit, :update]
      # 退会確認画面
      get '/customers/:id/unsubscribe' => 'customerss#unsubscribe', as: 'unsubscribe'
      # 論理削除用のルーティング
      patch '/customers/:id/withdrawal' => 'customerss#withdrawal', as: 'withdrawal'
    end

 namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update, :destroy]
    resources :impressions, only:[:index, :show, :destroy]
    resources :fields, only:[:index, :create, :update, :destroy]
 end
end