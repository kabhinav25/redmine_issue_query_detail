Rails.application.routes.draw do
  get 'issue_query_detail/:id', :to => 'issue_query_detail#issue_detail', :as => 'issue_query_detail'
end