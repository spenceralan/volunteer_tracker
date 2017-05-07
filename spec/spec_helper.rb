require("rspec")
require("pg")
require("project")
require("volunteer")
require("organization")
require("securerandom")
require("capybara/rspec")

ENV["rack_env"] = "test"

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("delete from volunteers *;")
    DB.exec("delete from projects *;")
    DB.exec("delete from hours *;")
  end
end