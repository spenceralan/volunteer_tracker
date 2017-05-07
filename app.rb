require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "./lib/volunteer"
require "./lib/project"
require "./lib/organization"
require "pry"
require "pg"

also_reload "lib/**/*.rb"

get "/" do
  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

post "/project" do
  name = params.fetch("project_name")
  project = Project.new({name: name})
  project.save

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

get "/project/:id" do
  project_id = params.fetch("id")
  @project = Project.find(project_id)
  erb :project
end

patch "/project" do
  updated_name = params.fetch("name")
  project_id = params.fetch("project_id")
  project = Project.find(project_id)
  project.update_attribute("name", updated_name)

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

delete "/project" do
  project_id = params.fetch("project_id")
  project = Project.find(project_id)
  project.delete

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

post "/volunteer" do
  name = params.fetch("volunteer_name")
  volunteer = Volunteer.new({name: name})
  volunteer.save

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

get "/volunteer/:id" do
  volunteer_id = params.fetch("id")
  @volunteer = Volunteer.find(volunteer_id)
  project = Project.find(@volunteer.project_id)
  @project = project == nil ? "none" : project.name
  @projects = Organization.projects
  erb :volunteer
end

patch "/assign-volunteer" do
  volunteer_id = params.fetch("volunteer_id")
  project_id = params.fetch("project_id")
  Organization.assign_project_to_volunteer(volunteer_id,project_id)
  @volunteer = Volunteer.find(volunteer_id)
  project = Project.find(@volunteer.project_id)
  @project = project == nil ? "none" : project.name
  @projects = Organization.projects
  erb :volunteer
end

patch "/volunteer" do
  updated_name = params.fetch("name")
  volunteer_id = params.fetch("volunteer_id")
  volunteer = Volunteer.find(volunteer_id)
  volunteer.update_attribute("name", updated_name)

  @projects = Organization.projects
  @volunteers = Organization.volunteers
  erb :index
end

delete "/volunteer" do
  volunteer_id = params.fetch("volunteer_id")
  volunteer = Volunteer.find(volunteer_id)
  volunteer.delete

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end