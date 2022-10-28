# frozen_string_literal: true

# (с) goodprogrammer.ru
#
# Контроллер, управляющий пользователями
class UsersController < ApplicationController
  # Встроенный в девайз фильтр — посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show]
  before_action :set_user!

  # Задаем объект @user (текущий юзер) для шаблонов и экшенов
  before_action :set_current_user, except: [:show]

  before_action :authorize_user!, except: [:show]
  after_action :verify_authorized, except: [:show]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('controllers.users.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user!
    @user = User.find params[:id]
  end

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def authorize_user!
    authorize(@user || User)
  end
end
