# frozen_string_literal: true

Rails.application.routes.draw do
  # например localhost/ru/questions, localhost/en/questions, localhost/questions
  # locale: /#{I18n.available_locales.join("|")}/ - проверка, что запрошенная локаль входит
  # в массив %i[en ru], а ("|") - "или" (локаль или такая, или такая.....)
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    root 'events#index'

    resources :events do
      # вложенный ресурс комментов
      resources :comments, only: %i[create destroy]
      resources :photos, only: %i[create destroy]
      resources :subscriptions, only: %i[create destroy]

    end

    resources :users, only: %i[show edit update]
  end
end
