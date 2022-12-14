# frozen_string_literal: true

# Контроллер вложенного ресурса комментариев
class CommentsController < ApplicationController
  # задаем "родительский" event для коммента
  before_action :set_event, only: %i[create destroy]

  # задаем сам коммент
  before_action :set_comment, only: [:destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    # проставляем комменту юзера, если юзер задан
    @new_comment.user = current_user

    if @new_comment.save
      # уведомляем всех подписчиков о новом комментарии
      EventEmailNotificationJob.perform_later(@new_comment) unless @event.notifications == false

      # если сохранился успешно, редирект на страницу самого события
      redirect_to @event, notice: t('controllers.comments.created')
    else
      # если ошибки — рендерим здесь же шаблон события
      render 'events/show', alert: t('controllers.comments.error')
    end
  end

  def destroy
    message = { notice: t('controllers.comments.destroyed') }

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = { alert: t('controllers.comments.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(event, comment)
    # собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq

    # XXX: Этот метод может выполняться долго из-за большого числа подписчиков
    # поэтому в реальных приложениях такие вещи надо выносить в background задачи!
    all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_later
    end
  end
end
