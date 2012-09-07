require 'spec_helper'

describe Bridge do
	include Bridge

	describe 'run_mysql_cmd' do
		it "runs a mssql command and returns the result" do
			puts run_mysql_cmd('SELECT COUNT(assgt_id) FROM assignments')
		end
	end
		
end
