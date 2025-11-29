class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :aliases, array: true, default: []
      t.string :category
      t.integer :popularity, default: 0

      t.timestamps
    end

    add_index :skills, :slug, unique: true
    add_index :skills, :aliases, using: :gin
  end
end
