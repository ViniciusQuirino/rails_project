class AddAdminToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :admin, :boolean, default: false
    #default: false os que já estavam no banco e os novos vai iniciar com falso
  end
end
