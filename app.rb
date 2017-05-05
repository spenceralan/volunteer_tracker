require 'sinatra'
require 'sinatra/reloader'
require './lib/volunteer'
require './lib/project'
require './lib/organization'
require 'pry'

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})


get('/') do
  erb(:index)
end
