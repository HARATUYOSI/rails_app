class CreateMicropostHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :micropost_hashtags do |t|
      t.references :micropost, foreign_key: true, null: false
      t.references :hashtag, foreign_key: true, null: false
      t.timestamps
      t.index [:hashtag_id, :micropost_id], unique: true
    end
  end
end
