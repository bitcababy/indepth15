class UsersController < ApplicationController
  protect_from_forgery

    respond_to do |format|
      format.html { render layout: !request.xhr?}
    end
  end

end
