# This migration comes from solidus_blogging (originally 20130706015658)
class AddAuthorInfoFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :spree_users do |t|
      t.string :nickname
      t.string :website_url
      t.string :google_plus_url
      t.text :bio_info
    end
  end
end
