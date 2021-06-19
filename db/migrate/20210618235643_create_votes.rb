class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
