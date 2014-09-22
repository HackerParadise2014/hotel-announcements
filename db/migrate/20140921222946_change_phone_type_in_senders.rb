class ChangePhoneTypeInSenders < ActiveRecord::Migration
  def change
  	change_column :senders, :phone, :string
  end
end
