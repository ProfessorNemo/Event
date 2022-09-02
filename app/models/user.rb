class User < ApplicationRecord
  # Юзер может создавать много событий
  has_many :events, dependent: :destroy

  # У юзера должно быть имя не длиннее 35 букв
  validates :name, presence: true, length: { maximum: 35 }

  #  без обращения к DNS-почтовым серверам для проверки существования доменного
  # проверяем корректность вводимых емэйлов
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
end
