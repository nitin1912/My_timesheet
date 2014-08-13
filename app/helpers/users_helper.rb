module UsersHelper
  def error_messages(field)
    if @employee.user.errors[field].any?
      message = @employee.user.errors[field].first
    end
  end
end
