# frozen_string_literal: true

class MailSentAboutSubscriberJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    event = subscription.event

    EventMailer.subscription(event, subscription).deliver_later
  end
end
