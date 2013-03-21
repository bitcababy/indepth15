class UsersController < ApplicationController
  protect_from_forgery

  def signin_form
    respond_to do |format|
      format.html { render layout: !request.xhr?}
    end
  end

end
