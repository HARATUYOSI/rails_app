class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :micropost, foreign_key: true, null: false

      t.timestamps
      t.index [:user_id, :micropost_id], unique: true
    end
  end
end
