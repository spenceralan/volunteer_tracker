require "helper_spec"

describe "Volunteer" do
  let(:new_project1) { Project.new( {:name => "Save the Whales"} ) }
  let(:new_project2) { Project.new( {:name => "Save the Trees"} ) }

  let(:new_volunteer1) { Volunteer.new( {:name => "Sally Jean", :project_id => new_project1.project_id} ) }
  let(:new_volunteer2) { Volunteer.new( {:name => "Marty Pants", :project_id => new_project2.project_id} ) }

  let(:results) { DB.exec("select * from volunteers") }

  describe "#initialize" do
    it "creates an initial volunteer object" do
      expect(new_volunteer1.name).to eq "Sally Jean"
    end
  end

  describe "#save" do
    it "saves a single record to the volunteer table in the database" do
      new_volunteer1.save
      expect(results.to_a.first["name"]).to eq "Sally Jean"
    end
  end

  describe ".objectify" do
    it "returns an array with a single volunteer object" do
      new_volunteer1.save
      volunteers = Volunteer.objectify(results).first
      expect(volunteers).to be_kind_of(Volunteer)
      expect(volunteers.name).to eq "Sally Jean"
    end

    it "preserves the id of the initial object" do
      new_volunteer1.save
      volunteers = Volunteer.objectify(results).first
      expect(volunteers.volunteer_id).to eq new_volunteer1.volunteer_id
    end

    it "returns an array with multiple volunteer objects" do
      new_volunteer1.save
      new_volunteer2.save
      volunteers = Volunteer.objectify(results)
      expect(volunteers.length).to eq 2
    end
  end
  
  describe "#delete" do
    it "deletes an entry from the database" do
      new_volunteer1.save
      new_volunteer1.delete
      expect(results.to_a.length).to eq 0
    end

    it "deletes the correct entry from the database" do
      new_volunteer1.save
      new_volunteer2.save
      new_volunteer1.delete
      volunteers = Volunteer.objectify(results)
      expect(volunteers.length).to eq 1
      expect(volunteers.first.name).to eq "Marty Pants"
    end
  end
  
  describe "#update_attribute" do
    it "updates the name of a volunteer" do
      new_volunteer1.save
      new_volunteer1.update_attribute("name", "Bart Simpson")
      volunteers = Volunteer.objectify(results)
      expect(volunteers.first.name).to eq "Bart Simpson"
      expect(new_volunteer1.name).to eq "Bart Simpson"
    end

    it "updates the project of a volunteer" do
      new_volunteer1.save
      new_volunteer1.update_attribute("project_id", new_project2.project_id)
      volunteers = Volunteer.objectify(results)
      expect(volunteers.first.project_id).to eq new_project2.project_id
      expect(new_volunteer1.project_id).to eq new_project2.project_id
    end
  end

  describe ".find" do
    it "returns the correct volunteer object when searched by volunteer id" do
      new_volunteer1.save
      new_volunteer2.save
      expect(Volunteer.find(new_volunteer1.volunteer_id).volunteer_id).to eq new_volunteer1.volunteer_id
    end
    
  end
  
end

