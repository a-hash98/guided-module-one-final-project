class CreateGameplays <ActiveRecord::Migration[5.1]
  def change
    create_table :game_plays do |t|
      t.boolean :result
      t.integer :user_id
      t.integer :game_id
      #t.datetime :played_at
    end
  end
end
