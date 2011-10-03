# ユーザ設定値の名称を保持する ActiveRecord クラス
class UserConfigurationName < ActiveRecord::Base
  has_many :user_configuration_values

  validates :name, :uniqueness => true

  def ==(other)
    return self.name == other.name
  end

  def eql?(other)
    return self == other
  end

  def hash
    return name.hash
  end
end
