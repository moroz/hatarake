class CreateOffersSkillsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :offers, :skills do |t|
      t.index :offer_id
      t.index :skill_id
    end
  end
end
