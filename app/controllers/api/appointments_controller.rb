class Api::AppointmentsController < ApplicationController
  
  def index
    # head :ok
    if params[:past] == "0"
      # future appointments (includes today's date)
      appointments = Appointment.where("DATE(start_time) >= ?", Date.today)
    elsif params[:past] == "1"
      # past appointments
      appointments = Appointment.where("DATE(start_time) < ?", Date.today)
    elsif params[:length] && params[:page]
      page_start = (params[:page].to_i - 1) * params[:length].to_i
      appointments = Appointment.limit(params[:length]).offset(page_start)
    else   
      appointments = Appointment.all
    end
      
    formattedForRender = []
    
    # TODO: install serializer gem in docker container to boost performance
      appointments.each do |appt|
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
    # Run below command from terminal to insert new appointment into the database
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
