require "securerandom"

class Project

  attr_accessor :project_id
  attr_accessor :name

  def initialize(attrs)
    self.project_id = attrs.fetch(:project_id, SecureRandom.uuid)
    self.name = attrs.fetch(:name)
  end
  
  def save
    DB.exec("insert into projects (project, name)
             values ('#{project_id}','#{name}')")
  end
  
  def update_attribute(type, attribute)
    send("#{type}=", attribute)
    DB.exec("update volunteers set #{type} = '#{attribute}
             where project_id = '#{project_id}")
  end

  def delete
    DB.exec("delete from projects where project_id = '#{project_id}'")
  end

  def self.objectify(dataset)
    dataset.map do |record|
      Patron.new({project_id: record["project_id"], name: record["name"]})
    end
  end

end
