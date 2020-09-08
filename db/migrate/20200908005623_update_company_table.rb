class UpdateCompanyTable < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :companies do |t|
        dir.up { t.change :type, :string }
        dir.down { t.change :sector, :string }
      end
    end
  end
end
