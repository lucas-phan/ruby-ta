class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.

	# validate erorr
	rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
	rescue_from ::ActionController::RoutingError, with: :error_occurred
	protected 

	protect_from_forgery with: :exception
	private
	def current_user
		User.where(id: session[:user_id]).first

	end
	helper_method :current_user

	def permission 
		unless session[:user_role] == 2
	        # render :text => current_user.role # debug 
	        redirect_to login_path, alert: 'Not Authorized !! Please login with admin account.'
	    end
	end 

	def log_out 
	    session[:user_id] = nil
	    session[:user_role] = nil
    end

	def option(params)
		begin
		@rapram = Option.find_by_key(params)
		if @rapram
			@info = @rapram
		else
		    Option.find_by_key('key_not_found')
		end 
		rescue => exception
			@info = exception 
		end  
	end        
	helper_method :option
	
	def opt(params)
		begin
		@rapram = Option.find_by_key(params).value
		if @rapram
			@info = @rapram
		else
		    Option.find_by_key('key_not_found').value
		end 
		rescue => exception
			@info = exception 
		end  
	end        
	helper_method :opt

	def plugin 
      @template = Dir[Rails.root+'app/views/admin/options/*'].select{ |f| File.file? f }.map{ |f| File.basename f } 
      @template -= ["index.html.erb", "show.html.erb", "show.json.jbuilder",'new.html.erb','_form.html.erb','edit.html.erb', 'index.json.jbuilder', 'mailconfig.html.erb']  
  	end
  	helper_method :plugin

	def sendmail(sendto,subject,contents) 
		mail_server_port = Option.find_by_key('mail_server_port').read_attribute('value')
		mail_server_smtp_username = Option.find_by_key('mail_server_smtp_username').read_attribute('value')
		mail_server_smtp_password = Option.find_by_key('mail_server_smtp_password').read_attribute('value')
		mail_server_from = Option.find_by_key('mail_server_from').read_attribute('value')
		mail_server_smtp = Option.find_by_key('mail_server_smtp').read_attribute('value')
		mail_server_from_cc = Option.find_by_key('mail_server_from_cc').read_attribute('value')      
		require 'mail'  
		Mail.defaults do
			delivery_method :smtp, {
				:port      => mail_server_port,
				:address   => mail_server_smtp,      
				:user_name => mail_server_smtp_username,
				:password  => mail_server_smtp_password,
				:openssl_verify_mode => 'none',
			}  
		end  
		mail = Mail.deliver do
			to      sendto
			from    mail_server_from 
			subject subject
			html_part do
				body contents
			end   
		end         
	end 

	def sendmailcc(sendto,subject,contents) 
		mail_server_port = Option.find_by_key('mail_server_port').read_attribute('value')
		mail_server_smtp_username = Option.find_by_key('mail_server_smtp_username').read_attribute('value')
		mail_server_smtp_password = Option.find_by_key('mail_server_smtp_password').read_attribute('value')
		mail_server_from = Option.find_by_key('mail_server_from').read_attribute('value')
		mail_server_smtp = Option.find_by_key('mail_server_smtp').read_attribute('value')
		mail_server_from_cc = Option.find_by_key('mail_server_from_cc').read_attribute('value')      
		require 'mail'  
		Mail.defaults do
			delivery_method :smtp, {
				:port      => mail_server_port,
				:address   => mail_server_smtp,      
				:user_name => mail_server_smtp_username,
				:password  => mail_server_smtp_password,
				:openssl_verify_mode => 'none',
			}  
		end  
		mail = Mail.deliver do
			to      sendto
			cc      mail_server_from_cc
			from    mail_server_from 
			subject subject
			html_part do
				body contents
			end   
		end         
	end   


end
