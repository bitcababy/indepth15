class FileHandlerController < ApplicationController
	REDIRECT_URL = 'http://oldfiles.westonmath.org'

  def pass_on
		redirect_to "#{REDIRECT_URL}#{request.path}"
  end
end

# http://www.westonmath.org/teachers/monzj/alg2h/Summary%20of%20Topics%20for%20Prospective%20Algebra%20II%20Honors%20Students.pdf