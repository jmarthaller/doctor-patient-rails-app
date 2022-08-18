SimplePractice Programming Test
=======================

The goal of the SimplePractice programming test is to evaluate the programming abilities
of candidates. The ideal candidate would know Ruby, JavaScript, or another language with
great proficiency, be familiar with basic database and HTTP API principles, and able to
write clean, maintainable code. This test gives candidates a chance to show these
abilities.

Getting Your Environment Ready
------------------------------

You'll need a development computer with access to github.com. You'll also need to set up
Docker CE (https://www.docker.com/community-edition), which is free. Sample `Dockerfile`
and `docker-compose.yml` files are included in this repo along with a basic scaffolded
Rails application.

There is a `Makefile` included for your convenience that has sample commands for building
and managing your application via the command line.

Please make sure you can bring up your app with `make up` well before the start of the
test. You should be able to run the tests if the basic setup works.

```bash
$ make
$ make build
$ make dbcreate
$ make test
```

If you need to use generators with docker:

```bash
docker-compose run app bundle exec rails scaffold users
```

Or, alternatively, you can "ssh" into the container (to exit, type `exit` or `ctrl + d`)

```bash
$ make bash
$ bundle exec rails g scaffold users
```

**NOTE** since the generator runs inside of Docker (and this container runs as
the `root` user), you will need to change the permissions of the generated
files. The following command is added as a convenience and should be run after
generated files are created to avoid "write permission" failures.

```bash
sudo chown -R $USER .
```

OR

```bash
make chown
```

Evaluation Criteria
-------------------

When evaluating the program, the following are among the factors considered:

 * Does it run?
 * Does it produce the correct output?
 * How did _you_ gain confidence your submission is correct?
 * Were appropriate algorithms and data structures chosen?
 * Was it well written? Are the source code and algorithms implemented cleanly?
   Would we enjoy your code living along side our own?
 * Is it slow? For small to medium sized inputs, the processing delay should
   probably not be noticeable.


### Additional Notes to Requirement 5: 

I was unsure whether the structure of the JSON object listed in Requirement #5 was for the request of the POST action or the response: 

```json
{
  patient: { name: <string> },
  doctor: { id: <int> },
  start_time: <iso8604>,
  duration_in_minutes: <int>
}
```

I went with using the above JSON object structure as the response to the POST method, but have included the same create action if the intention was for this object to be included in the POST request: 

```ruby
def create
    # Run below command from terminal to POST new appointment (doctor_id and patient_id must be in db)
    # curl --header "Content-Type: application/json" --request POST --data '{ "patient": { "name": "Stew Ng" }, "doctor": { "id": 141 }, "start_time": "2022-07-16 00:00:00", "duration_in_minutes": 50 }' http://localhost:3000/api/appointments -v

    associated_patient = Patient.find_by(name: params[:patient][:name])
    associated_doctor = Doctor.find_by(id: params[:doctor][:id])
    params[:doctor_id] = associated_doctor[:id]
    params[:patient_id] = associated_patient[:id]
    new_appointment_hash = { "doctor_id"=>params[:doctor_id], "patient_id"=>params[:patient_id], "start_time"=>params[:start_time], "duration_in_minutes"=>params[:duration_in_minutes] }
    appointment_to_create_custom_request = Appointment.new(new_appointment_hash)
    if appointment_to_create_custom_request.save
      render json: appointment_to_create_custom_request, status: :created
    else
      render json: appointment_to_create_custom_request.errors, status: :unprocessable_entity 
    end
end
```

Terminal commands to run the action for either version are included the above code snippet. 
