# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :authenticate_user!, only: :create

  before_action :set_event, only: %i[create destroy]

  before_action :set_photo, only: :destroy

  def create
    @new_photo = @event.photos.build(photo_params)
    # Проставляем у фотографии пользователя
    @new_photo.user = current_user

    if @new_photo.save
      EventEmailNotificationJob.set(wait: 5.seconds).perform_later(@new_photo) unless @event.notifications == false

      redirect_to @event, notice: t('controllers.photos.created')
    else
      render 'events/show', alert: t('controllers.photos.error')
    end
  end

  def destroy
    message = { notice: t('controllers.photos.destroyed') }

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = { alert: t('controllers.photos.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
