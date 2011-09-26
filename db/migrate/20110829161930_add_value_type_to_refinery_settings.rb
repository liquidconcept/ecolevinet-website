class AddValueTypeToRefinerySettings < ActiveRecord::Migration
  def self.up
    add_column ::RefinerySetting.table_name, :form_value_type, :string
    RefineryConfig.setup
  end

  def self.down
    remove_column ::RefinerySetting.table_name, :form_value_type
  end
end
