module ProjectsHelper
  def display_error(field)
    if @project.errors[field].any?
      raw @project.errors[field].first+"<br>"
    end
  end
end
