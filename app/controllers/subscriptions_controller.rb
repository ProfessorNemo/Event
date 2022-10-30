# frozen_string_literal: true

#
# Контроллер вложенного ресурса подписок
class SubscriptionsController < ApplicationController
  # Задаем «родительский» event для подписки
  before_action :set_event, only: %i[create destroy]

  # Задаем подписку, которую юзер хочет удалить
  before_action :set_subscription, only: :destroy

  def create
    # Болванка для новой подписки
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      MailSentAboutSubscriberJob.perform_later(@new_subscription)

      redirect_to @event, notice: t('controllers.subscriptions.created')
    else
      render 'events/show', alert: t('controllers.subscriptions.error')
    end
  end

  def destroy
    message = { notice: t('controllers.subscriptions.destroyed') }

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: t('controllers.subscriptions.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    # .fetch разрешает в params отсутствие ключа :subscription
    # Если params.require(:subscription) - будет ошибка. Когда залогиненный
    # юзер подписывается на события, нет смысла передавать форму, не user_name,
    # не user_email, поэтому params[:subscription] - будет пустым
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
