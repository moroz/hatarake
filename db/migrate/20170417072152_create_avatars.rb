class CreateAvatars < ActiveRecord::Migration[5.0]
  def change
    create_table :avatars do |t|
      t.references :user, foreign_key: true
      t.attachment :image

      t.timestamps
    end
  end
end
