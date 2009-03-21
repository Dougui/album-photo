ActionController::Routing::Routes.draw do |map|
  map.resources :messages

  map.resources :groupes

  # Added custom post action (swfupload) to the photo resource
  map.resources :photos, :collection => { :swfupload => :post }
  map.root :controller => "news"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.connect '/comptes.xml', :controller => "comptes", :action => "index", :format => 'xml'
  map.connect '/categories.xml', :controller => "categories", :action => "index", :format => 'xml'
  map.connect '/categories.js', :controller => "categories", :action => "index", :format => 'js'
end
