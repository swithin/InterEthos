class AddCountryStateAndCityToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :country, :text
    add_column :collections, :state, :text
    add_column :collections, :city, :text
  end

  def self.down
    remove_column :collections, :country
    remove_column :collections, :state
    remove_column :collections, :city
  end
end