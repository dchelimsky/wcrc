ActionController::Routing::Routes.draw do |map|
  map.resources :cards
  map.resources :iterations
  map.resource :backlog
end
