Justmissedme::Application.routes.draw do
  get 'faq' => "pages#faq", :as => :faq

  root :to => 'people#find'
  post 'find' => 'people#list', :as => :list
end
