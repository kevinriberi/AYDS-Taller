class DeleteUsers < ActiveRecord::Migration[7.0]
    def change
      User.delete_all
    end
  end