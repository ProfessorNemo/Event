# frozen_string_literal: true

# (с) goodprogrammer.ru
#
# Контроллер, управляющий событиями
class EventsController < ApplicationController
  protect_from_forgery except: :show

  # Встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: %i[show index]

  # Задаем объект @event для экшена show
  before_action :set_event, only: [:show]

  # Задаем объект @event от текущего юзера для других действий
  before_action :set_current_user_event, only: %i[edit update destroy]

  before_action :password_guard!, only: [:show]

  before_action :authorize_event!, except: %i[index]
  after_action :verify_authorized, except: %i[index]

  def index
    @events = Event.randomize
  end

  def show
    authorize @event

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  rescue Pundit::NotAuthorizedError
    password_guard!
  end

  def new
    @event = current_user.events.build
  end

  def edit; end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    if @event.update event_params
      redirect_to @event, notice: t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: t('controllers.events.destroyed')
  end

  private

  def password_guard!
    # Если у события нет пина, то нам охранять нечего
    return true if @event.pincode.blank?
    # если юзер залогинен и текущий юзер совпадает с автором события
    return true if signed_in? && current_user == @event.user

    # Юзер на чужом событии (или не за логином). Проверяем, правильно ли передал
    # пинкод. Если правильно, запоминаем в куках этого юзера этот пинкод для
    # данного события.
    remember_pin = "events_#{@event.id}_pincode".to_sym

    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])

      # чтоб при следующем обращении к событию заново не вводить пин, сохраним
      # его в куках в ключе "events_#{@event.id}_pincode":
      # cookies.permanent["events_#{@event.id}_pincode".to_sym] = params[:pincode]
      cookies[remember_pin] = { value: params[:pincode], expires: 6.hours.from_now }
      cookies.encrypted.permanent[:user_id] = current_user.id
    end

    # Проверяем — верный ли в куках пинкод, если нет — ругаемся и рендерим форму
    pincode = cookies.permanent[remember_pin]

    return if @event.pincode_valid?(pincode)

    cookies.delete remember_pin

    flash.now[:alert] = t('controllers.events.wrong_pincode') if params[:pincode].present?

    render 'password_form'
  end

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  def authorize_event!
    authorize(@event || Event)
  end
end
