class CreateApplicantSkills < ActiveRecord::Migration
  def change
    create_table :applicant_skills do |t|
      t.references :applicant, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :applicant_skills, [:applicant_id, :skill_id], unique: true
  end
end
