class AddSlugToAdverts < ActiveRecord::Migration[5.2]
  def change
    add_column :adverts, :slug, :string
    add_index :adverts, :slug, unique: true
  end
end
