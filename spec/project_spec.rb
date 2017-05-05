require "helper_spec"

describe "Project" do
  let(:new_project) {Project.new({:name => "Save the Whales"})}
  let(:results) {DB.exec("select * from patrons where project_id = '#{project.project_id}'").to_a}

  describe "#initialize" do
    it "creates an initial project object" do
      expect(new_project.name).to eq "Save the Whales"
    end
  end
  
end

