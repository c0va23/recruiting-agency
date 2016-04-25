class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :name, null: false
      t.integer :validity_days, null: false
      t.decimal :salary, null: false
      t.text :contacts, null: false

      t.timestamps null: false
    end
  end
end
