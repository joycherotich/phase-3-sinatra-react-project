class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title 
      t.string :genre
      t.integer :rating
      t.integer :year
      t.integer :user_id
      t.string :image_url
      t.timestamps
    end
  end
end
