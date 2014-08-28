class EmployeeJob < Struct.new(:id)
  def perform
    Notifier.welcome_all(mail).deliver

  end
end
