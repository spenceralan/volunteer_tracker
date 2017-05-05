require "helper_spec"

describe "Project" do
  let(:new_project1) { Project.new( {:name => "Save the Whales"} ) }
  let(:new_project2) { Project.new( {:name => "Save the Trees"} ) }

  let(:new_volunteer1) { Volunteer.new( {:name => "Sally Jean", :project_id => new_project1.project_id} ) }
  let(:new_volunteer2) { Volunteer.new( {:name => "Marty Pants", :project_id => new_project2.project_id} ) }

  describe ".volunteers" do
    it "returns an array of all volunteers" do
      new_volunteer1.save
      new_volunteer2.save
      expect(Organization.volunteers.length).to eq 2
    end
  end

  describe ".projects" do
    it "returns an array of all volunteers" do
      new_project1.save
      new_project2.save
      expect(Organization.projects.length).to eq 2
    end
  end

  describe ".assign_volunteer_to_project" do
    it "adds a project to a volunteer" do
      new_volunteer3 = Volunteer.new({name: "Captain Planet"})
      new_volunteer3.save
      new_project2.save
      Organization.assign_project_to_volunteer(new_volunteer3.volunteer_id, new_project2.project_id)
      expect(Volunteer.find(new_volunteer3.volunteer_id).project_id).to eq new_project2.project_id
    end
    
    it "changes a project a volunteer is assigned to" do
    end
  end

end
