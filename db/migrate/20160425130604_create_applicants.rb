class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :name, null: false
      t.string :contact, null: false
      t.boolean :active, null: false
      t.decimal :expected_salary, null: false

      t.timestamps null: false
    end
  end
end
