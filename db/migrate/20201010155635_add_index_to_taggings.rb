class AddIndexToTaggings < ActiveRecord::Migration[5.2]
  def change
    add_index :taggings, :advert_id
    add_index :taggings, :tag_id
    add_index :taggings, %i[advert_id tag_id], unique: true
  end
end
