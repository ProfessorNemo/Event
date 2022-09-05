# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Юзер может создавать много событий
  has_many :events, dependent: :destroy

  # У юзера должно быть имя не длиннее 35 букв
  validates :name, presence: true, length: { maximum: 35 }

  #  без обращения к DNS-почтовым серверам для проверки существования доменного
  # проверяем корректность вводимых емэйлов
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true

  # При создании нового юзера (create), перед валидацией объекта выполнить
  # метод set_name (devise ни знает ничего о поле "name" потому что, которое
  # у нас presence: true)
  before_validation :set_name, on: :create

  validate :password_complexity

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
end
