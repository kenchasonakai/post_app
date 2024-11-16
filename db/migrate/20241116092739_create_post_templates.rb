class CreatePostTemplates < ActiveRecord::Migration[7.2]
  def change
    create_table :post_templates do |t|
      t.string :title, null: false
      t.text :content
      t.timestamps

      t.index :title, unique: true
    end
  end
end
