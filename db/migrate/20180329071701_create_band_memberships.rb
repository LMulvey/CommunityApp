class CreateBandMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :band_memberships do |t|
      t.integer :access_level, default: 0
      t.belongs_to :user, index: true
      t.belongs_to :band, index: true

      t.timestamps
    end
  end
end
