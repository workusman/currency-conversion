class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :api_keys, dependent: :destroy

  after_create :generate_api_key
  
  def generate_api_key
    self.api_keys.create!
  end
end
