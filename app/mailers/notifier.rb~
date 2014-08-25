class Notifier < ActionMailer::Base
  default from: 'admin@admin.com'

  def welcome(recipient)
    @employee = recipient
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png") 
    mail(to: @employee.user.email, subject: "Hello Rails Apps")
  end
end
