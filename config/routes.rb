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
    resources :customers do
      collection do
        get 'my_page'
        get 'information/edit', action: :edit
        patch 'information',action: :update
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
  end

 namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update, :destroy]
    resources :impressions, only:[:index, :show, :destroy]
    resources :fields, only:[:index, :create, :update, :destroy]
 end
end