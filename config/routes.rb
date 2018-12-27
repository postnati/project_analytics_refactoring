Rails.application.routes.draw do
  get 'productivity(/:locale_name/:resource_group_name/:time_grouping)', to: 'productivity#show'
  post 'productivity', to: 'productivity#filter'

  root 'productivity#show'
end
