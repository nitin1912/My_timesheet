class Sheet < ActiveRecord::Base
  attr_accessible :client_list_id, :project_id, :activity_id, :task, :date, :in_time, :out_time, :remarks, :comments, :status
  belongs_to :client_list
  belongs_to :project
  belongs_to :activity 
  belongs_to :employee
  belongs_to :user
  validates :client_list_id, :project_id, :activity_id, :task, :date, presence: true
  validate :time
  validate :not_future_date
  validate :not_future_time
  
  def time 
    if out_time <= in_time
      self.errors.add(:out_time, ' Greater than in time')
    end
  end
  
  def not_future_time

    if self.in_time >  DateTime.now.strftime('%d/%m/%Y %H:%M' )

      errors.add(:in_time, 'less than current time')
    end
  end

  def not_future_date
    if self.date.present?
      if self.date > Date.today
        errors.add(:date, 'Not more than today')
      end
    end
  end
end
