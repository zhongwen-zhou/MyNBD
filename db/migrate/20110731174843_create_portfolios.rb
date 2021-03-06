class CreatePortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolios, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :user_id, :null => false
      t.integer :stock_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :portfolios
  end
end
