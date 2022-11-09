# frozen_string_literal: true

class MailSentAboutSubscriberJob < ApplicationJob
  queue_as :sublist

  def perform(subscription)
    event = subscription.event

    EventMailer.subscription(event, subscription).deliver_now
  end
end
