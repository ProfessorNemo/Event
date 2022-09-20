# frozen_string_literal: true

Rails.application.routes.draw do
  # например localhost/ru/questions, localhost/en/questions, localhost/questions
  # locale: /#{I18n.available_locales.join("|")}/ - проверка, что запрошенная локаль входит
  # в массив %i[en ru], а ("|") - "или" (локаль или такая, или такая.....)
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    root 'events#index'

    resources :events do
      # вложенный ресурс комментовX
      resources :comments, only: %i[create destroy]
      resources :photos, only: %i[create destroy]
      resources :subscriptions, only: %i[create destroy]

      post :show, on: :member
    end

    resources :users, only: %i[show edit update]
  end
end

# Если у события есть пин-код, то при обращении к "events#show" в запросе будет
# рендериться форма ввода пинкода. В эту форму юзер вводит пинкод, нажимает отправить
# и при отправке эта же форма будет выдавать post-запрос по адресу этого же события,
# а именнно "events#show" (это GET-зпрос). Добавляем двойной функционал приема POST-
# запроса по этому же url.