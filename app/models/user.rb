# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Юзер может создавать много событий

  # У юзера должно быть имя не длиннее 35 букв
  validates :name, presence: true, length: { maximum: 35 }

  # Юзер может создавать много событий и комментариев
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy

  # без обращения к DNS-почтовым серверам для проверки существования доменного
  # проверяем корректность вводимых емэйлов
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true

  # При создании нового юзера (create), перед валидацией объекта выполнить
  # метод set_name (devise ни знает ничего о поле "name" потому что, которое
  # у нас presence: true)
  before_validation :set_name, on: :create

  validate :password_complexity

  # Если юзер уже подписывался, но хочет залогиниться, пройдя все валидации
  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  # Задаем юзеру случайное имя, если оно пустое
  def set_name
    self.name = "nemo №#{rand(777)}" if name.blank?
  end

  # проверка для сложности пароля
  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

    errors.add(:password, :password_error)
  end

  # Если подписчик вдруг захотел залогиниться
  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
