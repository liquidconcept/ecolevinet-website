class RemovePasswordSaltFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :password_salt
    # Make the current password invalid :(
    User.all.each do |u|
      u.update_attribute(:encrypted_password, u.encrypted_password[29..-1])
    end

    if (seed_file = Rails.root.join('db', 'seeds', 'users.rb')).file?
      load seed_file.to_s
      RefineryConfig.set_default_plugins_order
    end

  end

  def self.down
    add_column :users, :password_salt, :string
  end
end
