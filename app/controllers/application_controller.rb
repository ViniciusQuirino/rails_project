class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  # Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Pundit

  protected

  def configure_permitted_parameters
    # Para cadastro (sign_up)
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])

    # Para atualização de conta (account_update)
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end

  private

  # Pundit
  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back_or_to(root_path)
  end
end
