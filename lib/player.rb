class Player
  attr_reader :token, :active

  def initialize(name, token)
    @name = name
    @token = token
    @active = false
  end

  def activate
    @active = true
  end

  def deactivate
    @active = false
  end

  def id
    "#{@name}(#{@token})"
  end

  def choose_column
    gets.chomp.to_i
  end
end
