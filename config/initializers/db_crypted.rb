# save users database settings in global var
DB_CRYPTED = YAML::load(ERB.new(File.read(Rails.root.join("config","crypted_database.yml"))).result)[Rails.env]