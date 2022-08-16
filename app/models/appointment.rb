class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient


  # def doctor
  #   puts self.doctor_id
  # end

  # def patient
  #   self.patient.name
  # end

  # scope :filter_only_future, -> (start_time) { where start_time: start_time.to_date.past? == true }

    # def custom_jsonifier
    #   {
    #     id: self.id,
    #     patient: { name: self.patient.name },
    #     doctor: { name: self.doctor.name, id: self.doctor.id },
    #     created_at: self.created_at,
    #     start_time: self.start_time,
    #     duration_in_minutes: self.duration_in_minutes
    #   }
    # end
end
