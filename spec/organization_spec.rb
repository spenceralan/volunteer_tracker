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
end
