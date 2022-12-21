class RenameOfWorkshopsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :workshops, :remainging_sits, :remaining_sits
  end
end
