class UserConfiguration

  def self.names
    return UserConfigurationName.all.map(&:name).map(&:to_sym)
  end

  def self.names=(names)
    names.map(&:to_s).each do |name|
      next if UserConfigurationName.find_by_name(name)
      UserConfigurationName.create!(name: name)
      create_getter_and_setter(name)
    end
  end

  def user
    return @user
  end

  def user=(user)
    raise "Argument user must be a User" unless user.is_a?(User)
    @user = user
  end

  def user_id=(id)
    @user = User.find(id)
  end

  private

    def self.create_getter_and_setter(name)
      define_method(name) do
        @user.get_conf_value(name)
      end

      define_method(name + '=') do |value|
        @user.set_conf_value(name, value)
      end
    end
    private_class_method :create_getter_and_setter
end

