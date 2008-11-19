ActionController::Routing::Routes.draw do |map|
  map.resources :promotions


  map.category  '/category/:id', :controller => "products", :action => "category", :id => /[a-z\-]+/
  map.checkout  '/checkout', :controller => "orders", :action => "new"
  map.activate  '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.signup    '/signup', :controller => 'users', :action => 'new'
  map.login     '/login', :controller => 'sessions', :action => 'new'
  map.logout    '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:code', :controller => 'users', :action => 'reset_password'
  map.account   '/account', :controller => 'users', :action => 'account'

  map.resource :cart
  map.resources :cart_items
  map.resources :products
  map.resources :orders, :collection => { "payment_received" => :post }
  map.resources :news, :controller => "articles"
  map.resource :session
  map.resources :users

  map.admin  '/admin', :controller => "admin/products", :action => "index"
  map.namespace :admin do |admin|
    admin.resources :categories do |category|
      category.resource :image, :controller => "category_images"
    end
    admin.resources :articles do |article|
      article.resources :images, :controller => "article_images"
    end      
    admin.resources :sizes
    admin.resources :pages do |page|
      page.resource :image, :controller => "page_images"
    end
    admin.resources :users
    admin.resources :orders
    admin.resources :countries
    admin.resources :products do |product|
      product.resources :images, :controller => "product_images"
      product.resources :stock_units
    end
  end

  map.root          :controller => "home", :action => "index"
  map.home "/home", :controller => "home", :action => "index"
  map.pages '/:id', :controller => "pages", :action => "show"

  map.connect ':controller/:action/:id'
end