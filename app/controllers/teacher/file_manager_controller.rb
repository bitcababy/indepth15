# require 'el_finder/action'

class FileManagerController < ApplicationController
	# skip_before_filter :verify_authenticity_token, :only => ['elfinder']
	# include ElFinder::Action

	# def elfinder
	# 	args = {
	#       :perms => {
	#         # 'forbidden' => {:read => false, :write => false, :rm => false},
	#         #  /README/ => {:write => false},
	#          # /pjkh\.png$/ => {:write => false, :rm => false},
	#       },
	#       :extractors => {
	#         # 'application/zip' => ['unzip', '-qq', '-o'],
	#         #  'application/x-gzip' => ['tar', '-xzf'],
	#        },
	#       :archivers => { 
	#         # 'application/zip' => ['.zip', 'zip', '-qr9'],
	#         # 'application/x-gzip' => ['.tgz', 'tar', '-czf'],
	#       },
	#       :thumbs => false
	# 	}
	# 	
	# 	if Rails.env == 'production'
	# 		args.merge!({
	# 			:root => '/',
	#       	:url => 'http://files.westonmath.org',
	# 		})
	# 	else
	# 		args.merge!({
	# 			:root => File.join(Rails.public_path, 'system', 'elfinder'),
	#       	:url => '/system/elfinder',
	#      })
	# 	params.merge!({cmd: 'home'})
	#     h, r = ElFinder::Connector.new(args).run(params)
	# 
	#     headers.merge!(h)
	#     render (r.empty? ? {:nothing => true} : {:text => r.to_json}), :layout => false
	# 	end
	# end
end
