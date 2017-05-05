require "helper_spec"

describe "Project" do
  let(:new_project) { Project.new( {:name => "Save the Whales"} ) }
  let(:results) {DB.exec("select * from projects where project_id = '#{new_project.project_id}'").to_a}

  describe "#initialize" do
    it "creates an initial project object" do
      expect(new_project.name).to eq "Save the Whales"
    end
  end

  describe "save" do
    it "saves a single record to the project table in the database" do
      new_project.save
      expect(results.first["name"]).to eq "Save the Whales"
    end
  end
  
end

