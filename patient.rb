class Patient
  attr_reader :name, :ailment, :id

  def initialize(name, id, ailment)
    @name    = name
    @id      = id
    @ailment = ailment
  end

  def ailment_change(ailment)
    @ailment = ailment 
  end
end
