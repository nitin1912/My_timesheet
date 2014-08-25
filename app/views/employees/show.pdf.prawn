
pdf.image "#{Rails.root.to_s+'/public'+@employee.photo.url(:thumb).split('?')[0]}" 
pdf.text  "First Name: #{@employee.first_name}" 
pdf.text  "Last Name:  #{@employee.last_name}" 
pdf.text  "Employee Code: #{@employee.employee_code}" 
pdf.text  "Email: #{@employee.user.email}" 
pdf.text  "Username: #{@employee.user.username}"

