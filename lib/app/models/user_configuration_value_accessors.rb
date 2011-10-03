# ユーザ設定値を設定・取得するメソッドを提供するモジュール。
# クラス User に include して使用する
module UserConfigurationValueAccessors
  extend ActiveSupport::Concern

  included do
    has_many :user_configuration_values
  end

  # ユーザ設定値を取得する。
  # 設定されていない場合は nil を返すので、設定値が nil の場合と
  # 区別することはできない
  # <em>name</em> :: 取得する設定値の名称
  # 返り値 :: ユーザ設定値
  def get_conf_value(name)
    obj_name = UserConfiguration.get_user_configuration_name(name)
    obj_value = user_configuration_values.detect { |value| value.user_configuration_name == obj_name }

    return obj_value && Marshal.load(obj_value.value)
  end

  # ユーザ設定値を設得する
  # <em>name</em> :: 設定する設定値の名称
  # <em>value</em> :: 設定する設定値
  def set_conf_value(name, value)
    obj_name = UserConfiguration.get_user_configuration_name(name)
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
end

