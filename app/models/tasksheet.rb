class Tasksheet < ActiveRecord::Base
  attr_accessible :client_list_id, :project_id, :activity_id, :task, :date, :in_time, :out_time, :remarks, :comments
  belongs_to :client_list
  belongs_to :project
  belongs_to :activity 
  belongs_to :employee
  belongs_to :user
   acts_as_xlsx
  validates :client_list_id, :project_id, :activity_id, :task, :date, presence: true
  #validates_uniqueness_of :in_time 
  validate :time
  validate :not_future_date
  validate :not_future_time
  #validate :validations
  #:presence => true,  :date => { :before_or_equal_to => Proc.new { Date.today } }
  #validate :in_time, :date => { :before_or_equal_to => Proc.new { Time.now } }, :if => "date.present? && in_time.present?"
  #validates_time :out_time, :after => :in_time,
                #            :after_message => 'must be after in time'
                                #:before => :,
                                #:before_message => 'must be before lunch time'
  # validates_time :in_time, :before => Time.now
                #:before => Proc.new { Time.now }
 
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
