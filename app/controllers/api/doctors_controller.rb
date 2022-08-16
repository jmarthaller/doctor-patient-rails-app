class Api::DoctorsController < ApplicationController
  
    def index
        doctors = Doctor.all
        unscheduledDocs = doctors.select { |doc| doc.appointments.length == 0 }
        render json: unscheduledDocs
    end
  
  end