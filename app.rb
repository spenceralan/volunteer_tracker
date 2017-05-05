require "sinatra"
require "sinatra/reloader"
require "./lib/volunteer"
require "./lib/project"
require "./lib/organization"
require "pry"
require "pg"

also_reload "lib/**/*.rb"

DB = PG.connect({:dbname => "volunteer_tracker"})


get "/" do
  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

post "/project" do
  name = params.fetch("name")
  project = Project.new({name: name})
  project.save

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

get "/project/:id" do
  erb :project
end

post "/volunteer" do
  name = params.fetch("name")
  volunteer = Volunteer.new({name: name})
  volunteer.save

  @volunteers = Organization.volunteers
  @projects = Organization.projects
  erb :index
end

get "/volunteer/:id" do
  erb :volunteer
end