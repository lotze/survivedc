class Checkpoint < ActiveRecord::Base
  before_validation :set_secret_code
  
  def set_secret_code
    unless secret_code
      secret_code = random_code(5).downcase
    end
  end
end
