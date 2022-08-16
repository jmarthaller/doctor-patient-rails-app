class Api::AppointmentsController < ApplicationController
  
  def index
      # TODO: return all values
      # TODO: return filtered values
      # head :ok
      @appointments = Appointment.all

      render json: @appointments, except: [:updated_at]
  end

  

  def create
    # TODO:
  end
end
