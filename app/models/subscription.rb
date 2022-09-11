class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, 'valid_email_2/email': true, unless: -> { user.present? }

  # в рамках заданного event_id user_id или user_name должен быть уникален
  # (чтобы юзер больше 1 раза не смог подписаться на одно и то же событие)
  # валидация сработает, если есть юзер зарегистрированный
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  # сработает, если анонимный юзер
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :email_exists, unless: -> { user.present? }

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  def email_exists
    errors.add(:user_email, :already_exists) if User.find_by(email: user_email)
  end
end
