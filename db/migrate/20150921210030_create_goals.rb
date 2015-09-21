class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :body
      t.boolean :public_post, null: false, default: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
