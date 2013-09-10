class Interface
  attr_reader :hospital
  attr_accessor :authenticated

  def initialize(hospital)
    @hospital = hospital
    @authenticated = nil
  end

  def start
    get_user_login_input
    if @authenticated.nil?
      bad_login_sonic_garage
    else
      main_menu
    end
  end

  def check_authentication(username, password)
    @authenticated = hospital.check_employee_authentication(username, password)[0]
  end

  def main_menu
    main_menu_text
    case @authenticated.access_level?
      when :doctor then doctor_menu
      when :admin then admin_menu
      when :access_denied then access_denied
    end
  end

  def doctor_menu
    until @authenticated.nil?
      doctor_menu_text
      input = gets.chomp.downcase
      case input
        when "a" then hospital.list_patients 
        when "b" then hospital.add_patient_from_input
        when "c" then sonic_garage_menu
        when "exit", "quit"
          @authenticated = nil
        else
        invalid_command
      end
    end
    @authenticated = nil
  end

  def admin_menu
    doctor_menu
  end

  def confirm?
    confirm = gets.chomp.downcase
    confirm == "y" || confirm == "yes"
  end

  def sonic_garage_menu
    sonic_garage
    if confirm?
      hospital.list_patients 
      select_patient
      patient_to_sonic_garage = gets.chomp
      send_to_sonic_garage(patient_to_sonic_garage.to_i)
    end
  end

  def send_to_sonic_garage(patient_number)
    unless patient_number.between?(1, hospital.patients.length)
      puts "Invalid selection. Returning to base menu."
    else
      sent_to_sonic_garage(patient_number)
      hospital.patients[patient_number - 1].ailment_change("Sonic Garage")
      hospital.delete_patient(patient_number - 1)
    end
  end

  def get_user_login_input
    prompt_for_username
    username = gets.chomp
    prompt_for_password
    password = gets.chomp
    check_authentication(username, password)
  end
end
