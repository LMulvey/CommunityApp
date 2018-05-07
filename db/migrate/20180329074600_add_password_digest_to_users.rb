class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :initial_password, :string, default: 0
  end
end
