class AddBlogReferenceToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :blog, null: false, foreign_key: true
  end
end
