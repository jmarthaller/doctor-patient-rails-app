class Api::AppointmentsController < ApplicationController
  
  def index
    # TODO: return filtered values
    # head :ok
    
    @appointments = Appointment.all
    # future appointments
    # appointments = appointments.select { |appt| appt.start_time >= Date.today.to_date  }  
    # past appointments
    # appointments = appointments.select { |appt| appt.start_time < Date.today.to_date  }   
    
    formattedForRender = []
    
    # TODO: install serializer gem in docker container to boost performance
      @appointments.each do |appt|
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
    # Run from the command line to insert new appointment in the database
    # curl --header "Content-Type: application/json" --request POST --data '{"doctor_id": 54, "patient_id": 101, "duration_in_minutes": 50, "start_time": "2022-07-16 00:00:00"}' http://localhost:3000/api/appointments -v
    appointmentToCreate = Appointment.new(appointment_params)
    if appointmentToCreate.save
      formattedReturn = { patient: { name: appointmentToCreate.patient.name }, doctor: { id: appointmentToCreate.doctor.id }, start_time: appointmentToCreate.start_time, duration_in_minutes: appointmentToCreate.duration_in_minutes }
      render json: formattedReturn, status: :created
    else
      render json: appointmentToCreate.errors, status: :unprocessable_entity 
    end
  end

  private 

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :start_time, :duration_in_minutes)
  end
end
