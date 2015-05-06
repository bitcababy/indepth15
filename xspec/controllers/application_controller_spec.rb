require 'spec_helper'

describe ApplicationController do
	describe '#current_user'
	describe '#user_signed_in?'
	describe '#user_session'
	describe '#current_or_guest_user'
	describe '#guest_user'
	describe '#create_guest_user'
	
	
	describe 'render_404' do
		it "handles ActionController::RoutingError" do
			pending "Unfinished test"
			raise ActionController::RoutingError, 'foo'
			expect(assigns[:not_found_path]).to eq 'foo'
		end

		it "sets @not_found_path to the error message" do
			pending "Unfinished test"
			expect(assigns[:not_found_path]).to_not be_nil
		end
		pending "Unfinished test"
	end
	
	describe 'render_500' do
		it "handles fatal errors"
	end
	
end
