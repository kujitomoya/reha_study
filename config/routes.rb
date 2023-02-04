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
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'impressions/index'
    get 'impressions/show'
  end
  namespace :admin do
    get 'fields/index'
    get 'fields/edit'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'impressions/index'
    get 'impressions/new'
    get 'impressions/show'
    get 'impressions/edit'
  end
end