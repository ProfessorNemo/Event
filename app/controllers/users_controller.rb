# frozen_string_literal: true

# (с) goodprogrammer.ru
#
# Контроллер, управляющий пользователями
class UsersController < ApplicationController
  # Встроенный в девайз фильтр — посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show]

  # Задаем объект @user (текущий юзер) для шаблонов и экшенов
  before_action :set_current_user, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('controllers.users.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end