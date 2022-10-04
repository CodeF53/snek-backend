class CreatePlays < ActiveRecord::Migration[6.1]
  def change
    create_table :plays do |t|
      t.integer :user_id

      t.integer :playtime # time in seconds that the game lasted
      t.integer :score # final score of game

      t.timestamps
    end
  end
end
