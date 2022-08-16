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

    # def custom_jsonifier(indexArray)
    #   arrToReturn = []
    #   indexArray.each do |entry| 
    #     customObj = {
    #         id: entry.self.id,
    #         patient: { name: entry.self.patient.name },
    #         doctor: { name: entry.self.doctor.name, id: entry.self.doctor.id },
    #         created_at: entry.self.created_at,
    #         start_time: entry.self.start_time,
    #         duration_in_minutes: entry.self.duration_in_minutes
    #       }
    #       arrToReturn << customObj
    #   end
    #   return arrToReturn
    # end
end
