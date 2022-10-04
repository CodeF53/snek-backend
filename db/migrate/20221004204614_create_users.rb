class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :session_cookie # should be an array with cookies and expire dates

      t.timestamps
    end
  end
end
