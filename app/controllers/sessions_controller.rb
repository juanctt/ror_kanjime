class SessionsController < ApplicationController

  def new
  	render :new, :layout => "signin"
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# Sign the user in and redirect to the user's show page.
  		sign_in user, :remember_me => params[:session][:remember_me]
  		redirect_back_or root_url
  	else
  		# Create an error message and re-render the signin form.
  		flash[:error] = 'Invalid email/password combination' # Not quite right!
  		redirect_to signin_url  	
  	end
  end

  def destroy
	 sign_out
	 redirect_to signin_url
  end


end
