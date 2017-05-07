class CreateVolunteers < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

    create_table :volunteers, id: :uuid do |v|
      v.column(:name, :varchar)
      v.column(:project_id, :uuid)

      v.timestamps
    end

    create_table :projects, id: :uuid do |p|
      p.column(:name, :varchar)

      p.timestamps
    end
  end
end
