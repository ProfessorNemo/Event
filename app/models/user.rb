# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 vkontakte github]
  # Юзер может создавать много событий

  # У юзера должно быть имя не длиннее 35 букв
  validates :name, presence: true, length: { maximum: 35 }

  # Юзер может создавать много событий и комментариев
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

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

  class << self
    def find_for_oauth(provider, access_token)
      find_or_create_user(access_token, provider)
    end

    private

    def find_or_create_user(access_token, provider)
      email = access_token.info.email
      return if email.blank?

      name =
        case provider
        when :github then access_token.info.nickname
        else access_token.info.first_name
        end

      avatarka =
        case provider
        when :vkontakte then access_token.extra.raw_info.photo
        else access_token.info.image
        end

      user = find_by(email: email) || create_oauth_user(access_token, name, avatarka)

      provider = access_token.provider
      uid = access_token.uid

      Identity.find_or_create_by(provider: provider, uid: uid, user: user).user
    end

    def create_oauth_user(access_token, name, avatarka)
      create(
        name: name.first(14),
        email: access_token.info.email,
        password: "#{Devise.friendly_token.first(16)}!".chars.shuffle.join,
        avatar: avatarka
      )
    end
  end

  # Переопределенный метод одного из родительских классов Devise
  # Отличается от родителького только тем, что использует .deliver_later
  # что кладет отправку почты в очередь фоновых задач
  # https://stackoverflow.com/questions/27518070/active-job-with-rails-4-and-devise
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

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
