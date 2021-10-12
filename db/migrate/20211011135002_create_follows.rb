class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :followee, null: false
      t.references :follower, null: false

      t.timestamps
    end

    add_foreign_key "follows", "users", column: "followee_id"
    add_foreign_key "follows", "users", column: "follower_id"
  end
end
