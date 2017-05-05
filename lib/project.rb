require "securerandom"

class Project

  attr_accessor :project_id
  attr_accessor :name

  def initialize(attrs)
    self.project_id = attrs.fetch(:project_id, SecureRandom.uuid)
    self.name = attrs.fetch(:name)
  end
  
  def save
    if invalid?(name)
      return
    end
    DB.exec("insert into projects (project_id, name)
             values ('#{project_id}','#{name}')")
  end
  
  def update_attribute(type, attribute)
    if invalid?(attribute)
      return
    else
      send("#{type}=", attribute)
      DB.exec("update projects set #{type} = '#{attribute}'
              where project_id = '#{project_id}'")
    end
  end

  def delete
    DB.exec("delete from projects where project_id = '#{project_id}'")
  end

  def self.find(project_id)
    return nil unless project_id
    objectify(DB.exec("select * from projects where project_id = '#{project_id}'")).first
  end

  def self.objectify(dataset)
    dataset.map do |record|
      Project.new({project_id: record["project_id"], name: record["name"]})
    end
  end

  private

  def invalid?(input)
    input.match?(/\As*\z/)
  end

end
