class UpdateCompanyTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :companies, :type, :sector
  end
end
