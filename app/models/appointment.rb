class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  def doctor
    self.doctor
  end

  def patient
    self.patient.name
  end
end
