class Api::AppointmentsController < ApplicationController
  
  def index
    # TODO: return filtered values
    # head :ok
    
    appointments = Appointment.all
    
    formattedForRender = []
    
    # TODO: use serializer gem to boost performance
      appointments.all.each do |appt|
        formattedHash = {
          id: appt.id,
          patient: { name: appt.patient.name },
          doctor: { name: appt.doctor.name, id: appt.doctor.id },
          created_at: appt.created_at,
          start_time: appt.start_time,
          duration_in_minutes: appt.duration_in_minutes
        }
        formattedForRender << formattedHash
      end

      render json: formattedForRender 
  end



  def create
    # TODO: post new appointment
  end

  private 

  # def appointment_params
  #   params.permit()
  # end
end
