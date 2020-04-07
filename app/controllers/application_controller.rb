class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  	devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  private
  	def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(User)
        user_path(current_user.id)
      else
        new_user_session_path
      end
    end


    def after_sign_out_path_for(resource_or_scope)
      flash[:notice] = "Signed out successfully."
      root_path
    end


end
