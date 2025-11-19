class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :company
      t.string :url
      t.string :location
      t.integer :status
      t.text :description
      t.text :notes
      t.string :compensation
      t.datetime :applied_at

      t.timestamps
    end

    add_index :jobs, %i[user_id status]
  end
end
