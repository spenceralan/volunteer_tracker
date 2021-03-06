require "securerandom"

module Organization
  def self.volunteers
    Volunteer.objectify(DB.exec("select * from volunteers order by name"))
  end
  
  def self.projects
    Project.objectify(DB.exec("select * from projects order by name"))
  end

  def self.assign_project_to_volunteer(volunteer_id, project_id)
    volunteer = Volunteer.find(volunteer_id)
    volunteer.update_attribute("project_id", project_id)
  end
  
end
