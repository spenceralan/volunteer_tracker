require "spec_helper"

describe "Project" do
  let(:new_project1) { Project.new( {:name => "Save the Whales"} ) }
  let(:new_project2) { Project.new( {:name => "Save the Trees"} ) }

  let(:results) {DB.exec("select * from projects")}

  describe "#initialize" do
    it "creates an initial project object" do
      expect(new_project1.name).to eq "Save the Whales"
    end
  end

  describe "#save" do
    it "saves a single record to the project table in the database" do
      new_project1.save
      expect(results.to_a.first["name"]).to eq "Save the Whales"
    end
  end

  describe ".objectify" do
    it "returns an array with a single Project object" do
      new_project1.save
      project = Project.objectify(results).first
      expect(project).to be_kind_of(Project)
      expect(project.name).to eq "Save the Whales"
    end

    it "preserves the id of the initial object" do
      new_project1.save
      projects = Project.objectify(results).first
      expect(projects.project_id).to eq new_project1.project_id
    end

    it "returns an array with a multiple Project objects" do
      new_project1.save
      new_project2.save
      projects = Project.objectify(results)
      expect(projects.length).to eq 2
    end
  end
  
  describe "#delete" do
    it "deletes an entry from the database" do
      new_project1.save
      new_project1.delete
      expect(results.to_a.length).to eq 0
    end

    it "deletes the correct entry from the database" do
      new_project1.save
      new_project2.save
      new_project1.delete
      projects = Project.objectify(results)
      expect(projects.length).to eq 1
      expect(projects.first.name).to eq "Save the Trees"
    end
  end
  
  describe "#update_attribute" do
    it "updates the name of a project" do
      new_project1.save
      new_project1.update_attribute("name", "Save the Unicorns")
      projects = Project.objectify(results)
      expect(projects.first.name).to eq "Save the Unicorns"
      expect(new_project1.name).to eq "Save the Unicorns"
    end
  end

  describe ".find" do
    it "returns the correct project object when searched by project id" do
      new_project1.save
      new_project2.save
      expect(Project.find(new_project1.project_id).project_id).to eq new_project1.project_id
    end
    
  end
    
end

