class CreateAdverts < ActiveRecord::Migration[5.2]
  def change
    create_table :adverts do |t|
      t.string :title
      t.text :content
      t.string :picture
      t.hstore :address
      t.boolean :status, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
