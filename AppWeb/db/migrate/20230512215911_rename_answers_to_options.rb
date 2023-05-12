class RenameAnswersToOptions < ActiveRecord::Migration[7.0]
  def change
    rename_table :answers, :options
  end
end
