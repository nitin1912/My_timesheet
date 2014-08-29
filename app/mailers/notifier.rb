class Notifier < ActionMailer::Base
  default from: 'goldychauhan1912@gmail.com'

  def welcome(recipient)
    @employee = recipient
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png") 
    mail(to: @employee[0], subject: @employee[2], body: @employee[1])
  
  end
  
  def welcome_all(mail)
  #debugger
    users = mail[:user].split(" ")
    mail(to: users, subject: mail[:subject], body: mail[:message])
  end
 # handle_asynchronously :welcome_all
end
