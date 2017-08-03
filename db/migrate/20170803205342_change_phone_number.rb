class ChangePhoneNumber < ActiveRecord::Migration
  def self.up
    change_column :users, :phone_number, :string
  end

  def self.up
    change_column :users, :phone_number, :integer
  end
end
