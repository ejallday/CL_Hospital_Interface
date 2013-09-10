
require_relative 'patient'
require_relative 'employee'
require_relative 'hospital_interface'
require_relative 'hospital_print'

include HospitalPrinter
require 'bcrypt'

class Hospital
  attr_reader :hospital_name, :number_patients, :employees, :patients
  attr_accessor :number_employees, :last_patient_id

  def initialize(hospital_name)
    @hospital_name = hospital_name
    @patients = []
    @employees = []
    @last_patient_id = 100
  end

  def add_patient(patient)
    patients << patient
    @last_patient_id += 1
  end

  def delete_patient(index)
    patients.delete_at(index)
  end

  def add_employee(employee)
    employees << employee
  end

  def delete_employee
  end

  def list_employees
    employees.map { |person| "#{person.name}" }
  end 

  def list_patients
    name_column_length = maximum_name_length + 5
    output_patient_header(name_column_length)
    patients.each do |person|
      puts "#{person.name}" + " " * (name_column_length - person.name.length) + " |   #{person.id}   "
    end
  end

  def maximum_name_length
    patients.map {|p| p.name.length}.max || 2
  end

  def output_patient_header(name_column_length)
    puts "Patient" + " " * (name_column_length - ("Patient".length)) + " |   ID   "
  end

  def check_employee_authentication(username, password)
    employees.select{ |employee| employee.username == username && employee.password == password}
  end

  def add_patient_from_input
    get_patient_name
    patient_name = gets.chomp
    get_patient_ailment
    ailment = gets.chomp
    self.add_patient(Patient.new(patient_name, (last_patient_id + 1), ailment))
    patient_created
  end
end

childrens = Hospital.new("Childrens")
childrens.add_employee(ted = Admin.new("Eric", "eric", "password"))
gui = Interface.new(childrens)
gui.start
