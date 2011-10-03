module UserConfigurationValueAccessors
  extend ActiveSupport::Concern

  included do
    has_many :user_configuration_values
  end

  def get_conf_value(name)
    obj_name = get_user_configuration_name(name)
    obj_value = user_configuration_values.detect { |value| value.user_configuration_name == obj_name }

    return obj_value && Marshal.load(obj_value.value)
  end

  def set_conf_value(name, value)
    obj_name = get_user_configuration_name(name)
    clazz_name = obj_name.clazz
    obj_value = user_configuration_values.detect { |value| value.user_configuration_name == obj_name }

    if obj_value.nil?
      obj_name.clazz = value.class.name
    elsif value.class.name != clazz_name
      raise TypeError, "The class of the given value (#{value.class}) does not match the class in DB (#{clazz_name})"
    end

    unless obj_value
      obj_value = UserConfigurationValue.new(user_id: id, user_configuration_name_id: obj_name.id)
    end
    obj_value.value = Marshal.dump(value)

    obj_name .save!
    obj_value.save!

    # DB から読み直して、たった今設定した UserConfigurationValue を反映させる
    reload

    nil
  end

  private

    def get_user_configuration_name(name)
      obj_name = UserConfigurationName.find_by_name(name.to_s)
      raise NameError, "No value entry with a name of '#{name}'" unless obj_name

      return obj_name
    end
end

