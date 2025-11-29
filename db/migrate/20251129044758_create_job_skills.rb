class CreateJobSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :job_skills do |t|
      t.references :job, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.integer :years_required
      t.string :classification, default: "required"

      t.timestamps
    end

    add_index :job_skills, [:job_id, :skill_id], unique: true
  end
end
