class PasswordDigestToChefs < ActiveRecord::Migration[5.2]
  def change
    add_column :chefs, :password_digest, :string
  end
end
