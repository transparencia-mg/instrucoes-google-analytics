class CreateUrlClassifications < ActiveRecord::Migration[6.1]
  def change
    create_table :url_classifications do |t|

      t.timestamps
    end
  end
end
