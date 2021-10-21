class ApiKey < ApplicationRecord
  belongs_to :project
  validates :token, presence: true, uniqueness: true

  after_initialize :set_token, if: :new_record? 

  private

  def set_token
    self.token = loop do 
      generated_token = SecureRandom.hex
      break generated_token unless ApiKey.exists?(token: generated_token)
    end
  end
end
