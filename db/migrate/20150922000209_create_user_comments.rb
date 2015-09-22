class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.text :body, null: false
      t.references :user, index: true, foreign_key: true
      t.integer :author_id, null: false

      t.timestamps null: false
    end
  end
end
