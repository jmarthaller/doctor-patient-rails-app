# TODO: Seed the database according to the following requirements:
# - There should be 10 Doctors with unique names
# - Each doctor should have 10 patients with unique names
# - Each patient should have 10 appointments (5 in the past, 5 in the future)
#   - Each appointment should be 50 minutes in duration


Patient.destroy_all
Doctor.destroy_all
Appointment.destroy_all

puts "Destroying all instances"


puts "Seeding database"


# seed all doctors, storing id to access when creating patients
doctorArray = []
10.times do
    newDoc = Doctor.new(name: Faker::Name.name)
    doctorArray << newDoc.id
    newDoc.save
end


# seed all patients, storing id to access when creating appointments
patientArray = []
doctorArray.each do |doc|
    doctorByID = Doctor.find_by(id: doc)
    10.times do
        newPatient = Patient.new(name: Faker::FunnyName.name, doctor_id: doctorByID.id)
        patientArray << newPatient.id
        newPatient.save
    end
end



patientArray.each do |patient|
    patientById = Patient.find_by(id: patient)
    5.times do
        pastAppointment = Appointment.new(doctor_id: Doctor.all.sample.id, patient_id: patientById.id, duration_in_minutes: 50, start_time: Faker::Date.backward(days: 30))
        pastAppointment.save
    end
    5.times do 
        futureAppointment = Appointment.new(doctor_id: Doctor.all.sample.id, patient_id: patientById.id, duration_in_minutes: 50, start_time: Faker::Date.forward(days: 30))
        futureAppointment.save
    end

end


puts "Database seeded"

