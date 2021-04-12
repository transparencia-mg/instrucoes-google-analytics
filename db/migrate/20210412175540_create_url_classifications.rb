class CreateUrlClassifications < ActiveRecord::Migration[6.0]
  def change
    create_table :url_classifications do |t|
      t.references :level, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
