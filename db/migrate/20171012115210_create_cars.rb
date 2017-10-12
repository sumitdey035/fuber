class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string  :type,      null: false
      t.string  :model,     null: false
      t.string  :uniq_id,   null: false, unique: true
      t.decimal :lat,       null: false
      t.decimal :lng,       null: false
      t.boolean :available, default: true

      t.timestamps null: false
    end
  end
end
