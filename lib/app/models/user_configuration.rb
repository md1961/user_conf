# ユーザ設定値の入出力を司るラッパー・クラス
class UserConfiguration

  # UserConfigurationName に定義された名称の配列を返す
  def self.names
    return UserConfigurationName.all.map(&:name).map(&:to_sym)
  end

  # UserConfigurationName に名称を設定して、User#get_conf_value()、
  # User#set_conf_value() に渡す名称に使用できるようにする
  # <em>names</em> :: 設定する名称（String または Symbol）の配列
  def self.names=(names)
    names.map(&:to_s).each do |name|
      next if UserConfigurationName.find_by_name(name)
      UserConfigurationName.create!(name: name)
      create_getter_and_setter(name)
    end

    nil
  end

  # 設定値の所属先であるユーザを返す
  def user
    return @user
  end

  # 設定値の所属先であるユーザを設定する
  # <em>user</em> :: 設定するユーザに該当する User のインスタンス
  # 返り値 :: 設定した User のインスタンス
  def user=(user)
    raise "Argument user must be a User" unless user.is_a?(User)
    @user = user
  end

  # 設定値の所属先であるユーザを設定する
  # <em>id</em> :: 設定するユーザに該当する User のインスタンスの id
  # 返り値 :: 設定した User のインスタンス
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

