class Employee
  attr_reader :username, :password
  attr_accessor :name

  def initialize(name, username, password)
    @name = name
    @username = username
    @password = BCrypt::Password.create(password)
  end
  def name
    @name
  end

  def access_level?
    :access_denied
  end
end

class Admin < Employee
  def access_level?
    :admin
  end
end

class Janitor < Employee
end

class Doctor < Employee
  def access_level?
    :doctor
  end
end
