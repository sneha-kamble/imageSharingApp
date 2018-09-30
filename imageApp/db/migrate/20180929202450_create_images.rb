class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :name
      t.string :tagline
      t.string :owner
      t.references :album, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
