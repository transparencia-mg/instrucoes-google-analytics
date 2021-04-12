class CreateUrlClassifications < ActiveRecord::Migration[6.0]
  def change
    create_table :url_classifications do |t|
      t.string :url
      t.string :classification

      t.timestamps
    end
  end
end
