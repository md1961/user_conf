class UserConfigurationName < ActiveRecord::Base
  has_many :user_configuration_values

  validates :name, :uniqueness => true
end
