require "helper_spec"

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
      project = Project.objectify(results).first
      expect(project.project_id).to eq new_project1.project_id
    end

    it "returns an array with a multiple Project objects" do
      new_project1.save
      new_project2.save
      project = Project.objectify(results)
      expect(project.length).to eq 2
    end
  end
  
  describe "#delete"
  
end

