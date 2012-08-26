class FileHandlerController < ApplicationController
	REDIRECT_URL = 'http://westonmath.org'

  def pass_on
		redirect_to "#{REDIRECT_URL}#{request.path}"
  end
end
