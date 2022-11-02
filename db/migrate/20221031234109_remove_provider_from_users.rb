# frozen_string_literal: true

class RemoveProviderFromUsers < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :provider
    remove_column :users, :url
  end

  def down
    add_column :users, :provider, :string
    add_column :users, :url, :string
  end
end
