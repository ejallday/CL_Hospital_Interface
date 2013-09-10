require 'pry'
module HospitalPrinter
  MENU_TEXT_ARRAY = [
                    /BEGIN= MAIN MENU(.*?)=END/m,
                    /BEGIN= ACCESS DENIED(.*?)=END/m,
                    /BEGIN= DOCTOR MENU(.*?)=END/m,
                    /BEGIN= SONIC GARAGE CONFIRM(.*?)=END/m,
                    /BEGIN= BAD LOGIN SONIC GARAGE(.*?)=END/m,
                    /BEGIN= SELECT PATIENT(.*?)=END/m,
                    /BEGIN= SENT TO SONIC GARAGE(.*?)=END/m,
                    /BEGIN= PROMPT FOR USER(.*?)=END/m,
                    /BEGIN= PROMPT FOR PASSWORD(.*?)=END/m,
                    /BEGIN= PATIENT NAME(.*?)=END/m,
                    /BEGIN= PATIENT AILMENT(.*?)=END/m,
                    /BEGIN= PATIENT CREATED(.*?)=END/m
                    ]

  def read_file
    File.read('menus.txt')
  end

  def text_fetcher(index)
    read_file.match(MENU_TEXT_ARRAY[index]).captures
  end

  def main_menu_text
    menu_text = text_fetcher(0)[0]
    menu_text.gsub!("USER_NAME", @authenticated.name)
    
    menu_text.gsub!("ACCESS_LEVEL", @authenticated.access_level?.to_s)
    puts menu_text
  end

  def access_denied
    puts text_fetcher(1)[0]
  end

  def doctor_menu_text
    puts text_fetcher(2)[0]
  end
  
  def sonic_garage
    puts text_fetcher(3)[0]
  end

  def bad_login_sonic_garage
    puts text_fetcher(4)[0]
  end

  def invalid_command
    puts "Invalid command.  Try again."
  end

  def select_patient
    select_patient = text_fetcher(5)[0]
    puts select_patient.gsub!("PATIENT_NUMBER", hospital.patients.length.to_s)
  end

  def sent_to_sonic_garage(patient_number)
    sent_to_sonic_garage_text = text_fetcher(6)[0]
    puts sent_to_sonic_garage_text.gsub!("PATIENT_NAME", hospital.patients[patient_number - 1].name)
  end

  def prompt_for_username
    prompt_for_username_text = text_fetcher(7)[0]
    puts prompt_for_username_text.gsub!("HOSPITAL_NAME", hospital.hospital_name)
  end

  def prompt_for_password
    puts prompt_for_password_text = text_fetcher(8)[0]
  end

  def get_patient_name
    puts get_patient_name_text = text_fetcher(9)[0]
  end

  def get_patient_ailment
    puts get_patient_ailment_text = text_fetcher(10)[0]
  end

  def patient_created
   puts patient_created_text = text_fetcher(11)[0]
  end
end
