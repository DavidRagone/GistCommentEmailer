class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :html_url
      t.string :description
      t.datetime :github_created_at
      t.datetime :github_updated_at
      t.integer :comments
      t.boolean :public
      t.integer :id
      t.string :comments_url

      t.timestamps
    end
  end
end
