require "securerandom"

class Volunteer

  attr_accessor :volunteer_id
  attr_accessor :project_id
  attr_accessor :name

  def initialize(attrs)
    self.volunteer_id = attrs.fetch(:volunteer_id, SecureRandom.uuid)
    self.project_id = attrs.fetch(:project_id, nil)
    self.name = attrs.fetch(:name)
  end
  
  def save
    DB.exec("insert into volunteers (volunteer_id, name, project_id)
             values ('#{volunteer_id}','#{name}','#{project_id}')")
  end
  
  def update_attribute(type, attribute)
    send("#{type}=", attribute)
    DB.exec("update volunteers set #{type} = '#{attribute}'
             where volunteer_id = '#{volunteer_id}'")
  end

  def delete
    DB.exec("delete from volunteers where volunteer_id = '#{volunteer_id}'")
  end

  def self.find(volunteer_id)
    objectify(DB.exec("select * from volunteers where volunteer_id = '#{volunteer_id}'")).first
  end

  def self.objectify(dataset)
    dataset.map do |record|
      Volunteer.new({volunteer_id: record["volunteer_id"], name: record["name"],
                     project_id: record["project_id"]})
    end
  end

end
