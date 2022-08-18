# Seed the database according to the following requirements:
# - There should be 10 Doctors with unique names
# - Each doctor should have 10 patients with unique names
# - Each patient should have 10 appointments (5 in the past, 5 in the future)
# - Each appointment should be 50 minutes in duration


Patient.destroy_all
Doctor.destroy_all
Appointment.destroy_all

puts "Destroying all instances"


puts "Seeding database"

# TODO: prepend Dr. to each doctor's name
# seed all doctors, storing id to access when creating patients
doctor_array = []
10.times do
    new_doc = Doctor.create(name: Faker::Name.name)
    doctor_array << new_doc.id
end


# seed all patients, storing id to access when creating appointments
patient_array = []
doctor_array.each do |doc|
    doctor_by_id = Doctor.find_by(id: doc)
    10.times do
        new_patient = Patient.create(name: Faker::FunnyName.name, doctor_id: doctor_by_id.id)
        patient_array << new_patient.id
    end
end



patient_array.each do |patient|
    patient_by_id = Patient.find_by(id: patient)
    5.times do
        past_appointment = Appointment.new(doctor_id: Doctor.all.sample.id, patient_id: patient_by_id.id, duration_in_minutes: 50, start_time: Faker::Date.backward(days: 30))
        past_appointment.save
    end
    5.times do 
        future_appointment = Appointment.new(doctor_id: Doctor.all.sample.id, patient_id: patient_by_id.id, duration_in_minutes: 50, start_time: Faker::Date.forward(days: 30))
        future_appointment.save
    end
end

# create doctors with no appointments (Requirement #4)
2.times do 
    Doctor.create(name: Faker::Name.name)
end


puts "Database seeded"

