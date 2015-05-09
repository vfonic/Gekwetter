class AddIndexToMicropostsOnCreatedAt < ActiveRecord::Migration
  def change
    add_index :microposts, :created_at
  end
end
