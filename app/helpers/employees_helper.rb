module EmployeesHelper
  def display_error_messages(field)
    if @employee.errors[field].any?
      raw @employee.errors[field].first
    end
  end
end


