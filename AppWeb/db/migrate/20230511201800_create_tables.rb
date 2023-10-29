  class CreateTables < ActiveRecord::Migration[7.0]
    def change
      create_table :questions do |t|
        t.string :title
        t.text :content
        t.references :topic, :foreign_key => true
  
        t.timestamps
      end
    end
  end
