class Failure 
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def success?; false; end
  def failed?; true; end
end
