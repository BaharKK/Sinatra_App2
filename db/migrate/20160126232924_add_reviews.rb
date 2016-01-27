class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :song
      t.text :content
    end
  end
end
