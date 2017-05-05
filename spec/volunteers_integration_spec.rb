require "capybara/rspec"
require "./app"
require "helper_spec"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the volunteer path", {:type => :feature}) do

  let(:new_project1) { Project.new( {:name => "Save the Whales"} ) }
  let(:new_project2) { Project.new( {:name => "Save the Trees"} ) }

  let(:new_volunteer1) { Volunteer.new( {:name => "Sally Jean", :project_id => new_project1.project_id} ) }
  let(:new_volunteer2) { Volunteer.new( {:name => "Marty Pants", :project_id => new_project2.project_id} ) }

  it("will add a new volunteer") do
    visit("/")
    fill_in("volunteer_name", :with => "Frank Sinatra")
    click_button("add volunteer")
    expect(page).to have_content("Frank Sinatra")
  end

  it("will delete a volunteer") do
    new_volunteer1.save
    visit("/")
    click_link("Sally Jean")
    click_button("delete")
    expect(page).not_to have_content("Sally Jean")
  end

  it("will update a volunteer") do
    new_volunteer1.save
    visit("/")
    click_link("Sally Jean")
    fill_in("name", with: "Greg Pants")
    click_button("update")
    expect(page).not_to have_content("Sally Jean")
    expect(page).to have_content("Greg Pants")
  end

  it("will assign a volunteer to a project") do
    new_volunteer1.save
    new_project1.save
    visit("/")
    click_link("Sally Jean")
    click_button("Save the Whales")
    expect(page).to have_content("current project: Save the Whales")
  end
end

describe("the project path", {:type => :feature}) do

  let(:new_project1) { Project.new( {:name => "Save the Whales"} ) }
  let(:new_project2) { Project.new( {:name => "Save the Trees"} ) }

  let(:new_volunteer1) { Volunteer.new( {:name => "Sally Jean", :project_id => new_project1.project_id} ) }
  let(:new_volunteer2) { Volunteer.new( {:name => "Marty Pants", :project_id => new_project2.project_id} ) }

  it("will add a new project") do
    visit("/")
    fill_in("project_name", :with => "Best Project")
    click_button("add project")
    expect(page).to have_content("Best Project")
  end

  it("will delete a project") do
    new_project1.save
    visit("/")
    click_link("Save the Whales")
    click_button("delete")
    expect(page).not_to have_content("Save the Whales")
  end

  it("will update a project") do
    new_project1.save
    visit("/")
    click_link("Save the Whales")
    fill_in("name", with: "Save the Planet")
    click_button("update")
    expect(page).not_to have_content("Save the Whales")
    expect(page).to have_content("Save the Planet")
  end

  it("will show the projects on the volunteer page") do
    new_project1.save
    new_volunteer1.save
    visit("/")
    click_link("Sally Jean")
    expect(page).to have_content("Save the Whales")
  end
  
end