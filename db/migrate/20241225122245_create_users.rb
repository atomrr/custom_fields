class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.belongs_to :tenant, null: false
      t.jsonb :data, default: {}, null: false

      t.timestamps default: -> { 'now()' }
    end
  end
end
