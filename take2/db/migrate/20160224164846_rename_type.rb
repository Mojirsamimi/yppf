class RenameType < ActiveRecord::Migration
  def change
    rename_column :incomes, :type, :incometype
  end
end
