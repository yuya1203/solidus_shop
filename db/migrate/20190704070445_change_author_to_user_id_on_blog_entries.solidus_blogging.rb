# This migration comes from solidus_blogging (originally 20130704034730)
class ChangeAuthorToUserIdOnBlogEntries < ActiveRecord::Migration[4.2]
  def up
    remove_column :spree_blog_entries, :author
    add_column :spree_blog_entries, :author_id, :integer
    add_index :spree_blog_entries, :author_id
    Spree::Role.create!(:name => "blogger") unless Spree::Role.where(:name => "blogger").any?
  end
  def down
    add_column :spree_blog_entries, :author, :string
    remove_column :spree_blog_entries, :author_id
    Spree::Role.where(:name => "blogger").destroy_all
  end
end
