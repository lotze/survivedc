require 'net/smtp'
require 'nokogiri'

class SurvivedcMailer
  def self.friend_request_email(friend_request, sending_user)
    target_user = User.find_by_email(friend_request.target_email)
    approve_link = "http://www.survivedc.org/friend_requests/approve/#{friend_request.code}"
    subject_line = "#{sending_user.public_name} has invited you to the SurviveDC app!"
    html_body = "#{sending_user.public_name} (#{sending_user.email}) will be playing in Survive DC this Saturday!" +
      "<br/>Moreover, they'll be using the SurviveDC mobile app to track their checkins during the game -- and they want to invite you to share your status and location with them while you play.  (This will only share your location during the game, and only to the friends who you approve.)" +
      "<br/><br/>To sign up and approve this friendship, click here: <a href='#{approve_link}'>#{approve_link}</a>"
    if target_user
      subject_line = "#{sending_user.public_name} wants to see your status on the SurviveDC app!"
      html_body = "#{sending_user.public_name} (#{sending_user.email}) wants to see your SurviveDC status and location while you play on Saturday.  (This will only share your location during the game, and only to the friends who you approve.)" +
        "<br/><br/>To approve this friendship, click here: <a href='#{approve_link}'>#{approve_link}</a>"
    end
    
    send_email(friend_request.target_email, subject_line, html_body)
  end
  
  def self.activation_needed_email(user)
    #activate_href = activation_url(:code => user.activation_token)
    activate_href = "http://www.survivedc.org/activate/#{user.activation_token}"
    html_body = <<-BODY
You've registered for the SurviveDC app!  By registering, you'll be able to track your progress each year as well as coordinate your progress with friends.
<br />
<br />Your temporary password is: #{user.password}
<br /> 
<br />To access your info later or connect with friends, we'll just need you to confirm this email address, and you'll be good to go.  You can do that by clicking here: <a href='#{activate_href}'>#{activate_href}</a>
    BODY
    subject_line = "Confirm your email for SurviveDC!"
    
    send_email(user.email, subject_line, html_body)
  end
  
  def self.activation_success_email(user)
    html_body = "You've registered for the SurviveDC app!  We know, it's kind of clunky; we're sorry about that, but we hope it will still be useful. It shold be better next year.  :)"
    subject_line = "You've registered for the SurviveDC app!"
    
    send_email(user.email, subject_line, html_body)
  end

  def self.reset_password_email(user)
    @url  = "http://www.survivedc.org/password_resets/#{user.reset_password_token}/edit"
    html_body = "Okay!  You've requested a password reset. Go here to activate it: <a href='#{@url}'>#{@url}</a>."
    subject_line = "SurviveDC password reset request"
    
    send_email(user.email, subject_line, html_body)
  end
  
  def self.send_email(email, subject_line, html_body)    
    begin
      doc = Nokogiri::HTML(html_body)
      doc.css('script, link').each { |node| node.remove }
      doc.css('br').each { |node| node.replace("\n") }
      text_body = doc.css('body').text.split("\n").collect { |line| line.strip }.join("\n")
           
      gmail_login=Configurator::Application.config.gmail_login
      gmail_password=Configurator::Application.config.gmail_password
     
      together_body = <<-BODY
From: 'Survive DC' <#{gmail_login}>
To: #{email}
Subject: #{subject_line}

#{text_body}
      BODY
      
      smtp = Net::SMTP.new 'smtp.gmail.com', 587
      smtp.enable_starttls
      smtp.start("survivedc.org", gmail_login, gmail_password, :login) do
        smtp.send_message(together_body, gmail_login, email)
      end
    rescue Exception => e
      RAILS_DEFAULT_LOGGER.error("Error mailing #{subject_line} to #{email}: #{e.to_s}\n<br />\n#{e.backtrace}")
    end
  end
end
