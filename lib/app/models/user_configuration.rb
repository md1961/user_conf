class UserConfiguration

  def self.names
    return UserConfigurationName.all.map(&:name).map(&:to_sym)
  end

  def self.names=(names)
    names.map(&:to_s).each do |name|
      next if UserConfigurationName.find_by_name(name)
      UserConfigurationName.create!(name: name)
    end
  end
end

