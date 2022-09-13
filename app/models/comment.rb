# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true

  # поле должно быть, только если не выполняется user.present? (у объекта нe задан юзер)
  validates :user_name, presence: true, unless: -> { user.present? }

  # переопределяем метод, если есть юзер, выдаем его имя,
  # если нет -- дергаем исходный переопределенный метод
  def user_name
    # т.е. поле 'user_name' если нет user.name=nil
    user&.name || super
  end
end
