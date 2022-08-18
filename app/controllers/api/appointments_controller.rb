class Api::AppointmentsController < ApplicationController
  
  def index
    if params[:past] == "0"
      # future appointments (includes today's date)
      appointments = Appointment.where("DATE(start_time) >= ?", Date.today).includes(:doctor, :patient)
    elsif params[:past] == "1"
      # past appointments
      appointments = Appointment.where("DATE(start_time) < ?", Date.today).includes(:doctor, :patient)
    elsif params[:length] && params[:page]
      page_start = (params[:page].to_i - 1) * params[:length].to_i
      appointments = Appointment.limit(params[:length]).offset(page_start).includes(:doctor, :patient)
    else   
      appointments = Appointment.all.includes(:doctor, :patient)
    end
      
    formatted_for_render = []
    
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
    # See README for create action if provided JSON structure in Requirement #5 was intended for the request
    # Run below command from terminal to POST new appointment (doctor_id and patient_id must be in db)
    # curl --header "Content-Type: application/json" --request POST --data '{"doctor_id": 205, "patient_id": 897, "duration_in_minutes": 50, "start_time": "2022-07-16 00:00:00"}' http://localhost:3000/api/appointments -v

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
