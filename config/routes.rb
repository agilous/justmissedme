Justmissedme::Application.routes.draw do
  root :to => 'people#find'
  post 'find' => 'people#list', :as => :list
end
