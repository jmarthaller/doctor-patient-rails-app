class Api::DoctorsController < ApplicationController
  
    def index
        doctors = Doctor.all
        unscheduled_docs = doctors.select { |doc| doc.appointments.length == 0 }
        render json: unscheduled_docs
    end
  
  end