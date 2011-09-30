module UserConfigurationValueAccessors
  extend ActiveSupport::Concern

  included do
    has_many :user_configuration_values
  end

  def get_conf_value(name)
    obj_name = UserConfigurationName.find_by_name(name.to_s)
    raise NameError, "No value entry with a name of '#{name}'" unless obj_name

    obj_value = user_configuration_values.detect { |value| value.user_configuration_name == obj_name }
    return obj_value && Marshal.load(obj_value.value)
  end

  def set_conf_value(name, value)
    obj_name = UserConfigurationName.find_by_name(name.to_s)
    if obj_name
      clazz_name = obj_name.clazz
    else
      obj_name = UserConfigurationName.new(name: name.to_s)
      clazz_name = nil
    end

    if clazz_name
      unless value.class.name == clazz_name
        raise TypeError, "The class of the given value (#{value.class}) does not match the class in DB (#{clazz_name})"
      end
    else
      obj_name.clazz = value.class.name
    end

    obj_name.save!

    obj_value = user_configuration_values.detect { |value| value.user_configuration_name == obj_name }
    unless obj_value
      obj_value = UserConfigurationValue.new(user_id: id, user_configuration_name_id: obj_name.id)
    end
    obj_value.value = Marshal.dump(value)
    obj_value.save!

    nil
  end
end

