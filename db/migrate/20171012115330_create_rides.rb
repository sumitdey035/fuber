class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.references  :customer,    null: false
      t.references  :car,         null: false
      t.string      :start_point, null: false
      t.timestamp   :start_time,  null: false
      t.string      :end_point
      t.timestamp   :end_time
      t.decimal     :distance
      t.decimal     :price

      t.timestamps null: false
    end
  end
end
