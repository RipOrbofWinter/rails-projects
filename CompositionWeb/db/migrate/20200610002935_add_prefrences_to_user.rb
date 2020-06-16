class AddPrefrencesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prefrences, :string
  end
end
