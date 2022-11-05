# frozen_string_literal: true

class Event < ApplicationRecord
  # Событие принадлежит юзеру
  belongs_to :user

  has_one_attached :snapshot

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  # Для того, чтобы  рельсы понимали, какой класс лежит в связи
  # ':subscribers' - source: :user - это то поле в таблице subscriptions
  # на которое эта связь будет ссылаться
  has_many :subscribers, through: :subscriptions, source: :user

  # Заголовок должен быть, и не может быть длиннее 255 букв
  validates :title, presence: true, length: { maximum: 255 }

  # Также у события должны быть заполнены место и время проведения
  validates :address, presence: true
  validates :datetime, presence: true

  scope :randomize, -> { order('random()') }

  # Все, кто идет на событие
  def visitors
    [user, *subscribers].uniq
  end

  # совпадает ли переданный параметр с пинкодом этого события
  def pincode_valid?(pin2chek)
    pincode == pin2chek
  end
end
