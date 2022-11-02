# frozen_string_literal: true

class AddProviderAndUrlToUsers < ActiveRecord::Migration[6.1]
  change_table :users, bulk: true do |t|
    t.string :provider
    t.string :url
  end
end
