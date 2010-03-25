class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'InterEthos - Please activate your new account'
  
    # @body[:url]  = "http://localhost:3000/activate/#{user.activation_code}"
    @body[:url]  = "http://localhost:3000/activate?activation_code=#{user.activation_code}"
    # @body[:url]  = "http://interethos.net/activate?activation_code=#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'InterEthos - Your account has been activated!'
    @body[:url]  = "http://localhost:3000/"
    # @body[:url]  = "http://interethos.net/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "josh@swithin.com"
      @subject     = "[localhost:3000] "
      # @subject     = "[InterEthos.net] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
