class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_in_path_for(user)
    user.admin? ? admin_tests_path : tests_path
  end

  private

  def set_locale
    I18n.locale = if I18n.locale_available?(params[:lang])
                    params[:lang]
                  else
                    I18n.default_locale
                  end
  end
end
