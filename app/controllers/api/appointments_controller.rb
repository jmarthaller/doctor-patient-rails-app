class Api::AppointmentsController < ApplicationController
  
  def index
      # TODO: serialize values
      # TODO: return filtered values
      # head :ok

      appointments = Appointment.all
      # future
      # appointments = appointments.select { |appt| appt.start_time >= Date.today.to_date  }  
      # past
      # appointments = appointments.select { |appt| appt.start_time < Date.today.to_date  }   
      


      # past
      # appointments = appointments

      # @users = @users.where(email: search_params['email']) if search_params['email'].present?


      # if params[:start_time] < start_time.to_date.past? == true
      #   appointments = Appointment.select { |appt| appt.start_time >= Date.today.to_date }
      # else
      #   appointments = Appointment.select { |appt| appt.start_time <  Date.today.to_date }
      # end
      # appointments = appointments.filter_only_future(params[:start_time]) if params[:start_time].present?
      # puts params[:start_time]
      # puts appointments.methods
      # moddedAppointments = custom_jsonifier(appointments)
      render json: appointments
  end



  def create
    # TODO: post new appointment
  end

  private 

  # def appointment_params
  #   params.permit()
  # end
end
