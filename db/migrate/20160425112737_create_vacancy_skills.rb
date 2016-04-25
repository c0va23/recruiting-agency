class CreateVacancySkills < ActiveRecord::Migration
  def change
    create_table :vacancy_skills do |t|
      t.references :vacancy, index: true, foreign_key: true, null: false
      t.references :skill, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :vacancy_skills, [:vacancy_id, :skill_id], unique: true
  end
end
