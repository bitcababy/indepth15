#!/usr/bin/env ruby

require 'net/http'
require 'active_support/core_ext'

module Bridge
	@database = "whsmd_testing"
	@host = "db1.xoala.net"
	@user = "whswriter"

	@mysql_prefix = "mysql -B -N -u #{@user} -h #{@host} #{@database} -e "
	@server = 'http://0.0.0.0:3000'

	# class Assignment
	# 	attr_accessor :assgt_id, :teacher_id, :content
	# end
	# 		
	def run_mysql_cmd(cmd)
		stmt = "#{@mysql_prefix} '#{cmd}'"
		# puts stmt
		return %x{echo `#{stmt}`}
	end

	def find_one(table, is_new=true)
		run_mysql_cmd("SELECT id FROM #{table} WHERE sent=0 AND is_new=#{is_new ? 1 : 0} LIMIT 1").strip
	end

	# def cons_assignment(assgt_id)
	# 	teacher_id = run_mysql_cmd("SELECT teacher_id FROM assignments WHERE assgt_id=#{assgt_id}").strip
	# 	content = run_mysql_cmd("SELECT content FROM assignments WHERE assgt_id=#{assgt_id}")
	# 	return <<EOT
	# <?xml version="1.0" encoding="utf-8" ?>
	# 
	# <assignment>
	# 	<assgt_id>#{assgt_id}</assgt_id>
	# 	<teacher_id>#{teacher_id}</assgt_id>
	# 	<content><![CDATA[#{content}
	# 	]]></content>
	# </assignment>
	# EOT
	# end

	def do_create(controller, hash)
		uri = URI "#{@server}/#{controller}.xml"
		req = Net::HTTP::Post.new(uri.path)
		req.set_form_data hash
		res = Net::HTTP.start(uri.hostname, uri.port) do |http|
			http.request(req)
		end
	
		case res
		when Net::HTTPSuccess, Net::HTTPRedirection
			puts "success"
		else
			res.value
		end
	end

	def get_id(str)
		str.match(/"_id":("[^"]+"),/) {|m| return m[1]}
	end
	
	def get_assignment_id(assgt_id)
		uri = URI("#{@server}/assignments/get_one/#{assgt_id}.xml")
		res = Net::HTTP.get(uri)
		get_id(res)
	end

	def post_assignment(assgt_id)
		hash = {'assgt_id' => assgt_id}
		hash['teacher_id'] = run_mysql_cmd("SELECT teacher_id FROM assignments WHERE assgt_id=#{assgt_id}").strip
		hash['content'] = run_mysql_cmd("SELECT content FROM assignments WHERE assgt_id=#{assgt_id}")

		aid = get_assignment_id(assgt_id)
		if aid.empty?
			# is_new = run_mysql_cmd("SELECT is_new FROM assignments WHERE assgt_id=#{assgt_id}")
			do_create('assignments', hash)
		else
			do_update(controller, hash)
		end
	end
end

# 
# aid = find_one 'assignments'
# 
# # post_assignment(aid)
# 
# get_assignment('222')
# 
