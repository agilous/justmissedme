Jmm::Application.routes.draw do

  root :to => "pages#home"

  get "pages/home"
  get "pages/faq"

  match 'faq' => 'pages#faq'
  match "people" => "people#list"

end
