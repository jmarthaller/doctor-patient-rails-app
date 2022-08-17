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
      
    formatted_for_render = []
    
    # TODO: install serializer gem in docker container to boost performance
      appointments.each do |appt|
        formatted_hash = {
          id: appt.id,
          patient: { name: appt.patient.name },
          doctor: { name: appt.doctor.name, id: appt.doctor.id },
          created_at: appt.created_at,
          start_time: appt.start_time,
          duration_in_minutes: appt.duration_in_minutes
        }
        formatted_for_render << formatted_hash
      end

      render json: formatted_for_render 
  end



  def create
    # Run below command from terminal to insert new appointment into the database
    # curl --header "Content-Type: application/json" --request POST --data '{"doctor_id": 54, "patient_id": 101, "duration_in_minutes": 50, "start_time": "2022-07-16 00:00:00"}' http://localhost:3000/api/appointments -v
    appointment_to_create = Appointment.new(appointment_params)
    if appointment_to_create.save
      formatted_return = { patient: { name: appointment_to_create.patient.name }, doctor: { id: appointment_to_create.doctor.id }, start_time: appointment_to_create.start_time, duration_in_minutes: appointment_to_create.duration_in_minutes }
      render json: formatted_return, status: :created
    else
      render json: appointment_to_create.errors, status: :unprocessable_entity 
    end
  end

  private 

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :start_time, :duration_in_minutes)
  end
end
