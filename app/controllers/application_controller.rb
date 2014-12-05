class ApplicationController < ActionController::Base
  helper_method :current_user, :forbid!

  def index
    authenticate!
    redirect_to questions_path
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate!
    current_user || 
    redirect_to("/auth/saml?redirectUrl=#{URI::encode(request.path)}")
  end

  def forbid!
    render :status => :forbidden, 
      :text => 'You do not have rights to perform this operation.'
  end
end
