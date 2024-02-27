# frozen_string_literal: true

class EnableUuidExtension < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' # for PostgreSQL
  end
end
