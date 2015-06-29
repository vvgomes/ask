class ApplicationController < ActionController::Base
  helper_method :current_user, :forbid!

  def index
    redirect_to questions_path if current_user
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate!
    return if current_user 
    #redirect_to("/auth/saml?redirectUrl=#{URI::encode(request.path)}")
    original = request.env['HTTP_REFERER']
    redirect_to(root_path, :redirectUrl => request.path)
  end

  def forbid!
    render :status => :forbidden, 
      :text => 'You do not have rights to perform this operation.'
  end
end
