# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    # "NotAuthorizedError" - назв. ошибки. С помощью метода
    # "user_not_authorized" будем делать rescue
    rescue_from Pundit::NotAuthorizedError, with: :no_access

    private

    # редирект либо туда, где был юзер до попытки выполнения действия. Если
    # "request.referer" нет, то на заглавную страницу
    def no_access
      flash[:danger] = t('pundit.no_access')
      redirect_to(request.referer || root_path)
    end
  end
end
