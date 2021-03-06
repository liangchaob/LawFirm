Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
#   as :user do
#   get 'users', :to => 'users#show', :as => :user_root # Rails 3
# end


  # 管理员路由
  namespace :admin do
    resources :questions do
      resources :answers
    end
    resources :documents
     resources :feedbacks
     resources :orders
    resources :conversations
    resources :users do
      member do
        post :change_to_user
        post :change_to_lawyer
        post :change_to_vip
        post :change_to_visitor
      end
    end
  end

  # 普通用户路由
  namespace :account do
    resources :documents
    resources :feedbacks

    #order路由
    resources :orders do
      collection do
        post :create_m
        post :create_y
      end
      #支付路由
      member do
        post :pay_with_alipay
        post :pay_with_wechat
      end
    end

    resources :users
    resources :questions do
      resources :answers
      resources :conversations do
        member  do
          get :show_lawyer
         end
      end

      # 评价系统
      collection do
        post :rating
        get  :new_document
      end

    end

  end

  # 律师路由
  namespace :lawyer do
    resources :users
    resources :questions do
      resources :answers
    end
    resources :documents do
      resources :feedbacks
    end

  end

  # f783-站内通知
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end


  resources :welcome do

    collection do
      # post :pricing  #支付路由
      # 获取路人问题
      post :get_temp_question
    end

  end

  get "/price", to: "welcome#price"
  get "/about_us", to: "welcome#about_us"
  get "/help_term", to: "welcome#help_term"
  get "/contact_us", to: "welcome#contact_us"
  get "/sec_price", to: "welcome#sec_price"


  root 'welcome#index'

end
