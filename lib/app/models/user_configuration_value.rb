class UserConfigurationValue < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_configuration_name

  validates :user_configuration_name_id, :uniqueness => {:scope => :user_id}
end
