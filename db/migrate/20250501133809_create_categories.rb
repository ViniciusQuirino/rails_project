class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false #não permite o campo ser nulo

      t.timestamps
    end
  end
end
