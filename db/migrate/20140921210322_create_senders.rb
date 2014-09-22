class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.integer :phone

      t.timestamps
    end
  end
end
