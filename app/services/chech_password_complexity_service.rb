class ChechPasswordComplexityService < ApplicationService
  attr_reader :password, :required_complexity

  def initialize(password, required_complexity = 4)
    @password = password
    @required_complexity = required_complexity
  end

  def call
    score = uppercase_letters? + digits? + extra_chars? + downcase_letters?
    score >= required_complexity
  end

  private

  def digits?
    /\d/.match?(@password) ? 1 : 0
  end

  def downcase_letters?
    /[a-z]{1}/.match?(@password) ? 1 : 0
  end

  def extra_chars?
    /[\W_]/.match?(@password) ? 1 : 0
  end

  def uppercase_letters?
    /[A-Z]/.match?(@password) ? 1 : 0
  end
end
