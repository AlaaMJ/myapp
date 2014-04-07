class CreateRooms < ActiveRecord::Migration
   def up
    create_table :rooms do |t|
      t.integer "user_id"
      t.string "city"
      t.text "description"
      t.integer "price" 
      t.datetime "available_date"
      

      t.timestamps
     end
    add_index("rooms", "user_id")
     
  end
  
  def down
    
  	drop_table :rooms
  end
end
