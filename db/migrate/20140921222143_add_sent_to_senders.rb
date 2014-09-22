class AddSentToSenders < ActiveRecord::Migration
  def change
    add_column :senders, :sent, :boolean
  end
end
