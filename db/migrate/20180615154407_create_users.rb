class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :salt
      t.string :password
      t.string :language
      t.text :profileImage

      t.timestamps
    end
  end
end
