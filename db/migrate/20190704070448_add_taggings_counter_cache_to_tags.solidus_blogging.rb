# This migration comes from solidus_blogging (originally 20140901055153)
class AddTaggingsCounterCacheToTags < ActiveRecord::Migration[4.2]
  def self.up
    add_column :tags, :taggings_count, :integer, :default => 0
  end

  def self.down
    remove_column :tags, :taggings_count
  end
end