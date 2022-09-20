# frozen_string_literal: true

module SendMessage
  extend ActiveSupport::Concern

  included do
    def message(*args)
      EventMailer.photo(*args).deliver_later and return if args[1].is_a?(Photo)

      EventMailer.comment(*args).deliver_later
    end

    def departure(*args, &block)
      message(*args) and return unless block

      args[2].each(&block)
    end

    def notification_object(event, object)
      # собираем мейлы всех подписчиков события и
      # автора события в массив мэйлов, исключаем повторяющиеся:
      # all_emails = [event.subscriptions.map(&:user_email), [event.user.email]].uniq.flatten!
      # удаляем емэйл автора добавленной фотки (он может быть незарегистрированным юзером)
      # all_emails -= [object&.user&.email]

      all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq - [object&.user&.email]

      if all_emails.size <= 1
        # если всего 1 подписчик, исключая автора
        departure(event, object, all_emails)
      else
        # если больше одного подписчика, исключая автора
        departure(event, object, all_emails) { |mail| message(event, object, mail) }
      end
    end
  end
end
