class CreateOutput < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      t.text :data
      t.text :datatype
      t.text :description
      t.datetime :datetime
    end
  end
end
