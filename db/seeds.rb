# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

ts = Time.new

# generate the checkpoints -- not for start
Checkin.delete_all
Checkpoint.delete_all
Checkpoint.create!(:latitude => 38.902712, :longitude => -77.021638, :street_address => "NY & 7th", :name => "Omega", :secret_code => 'omega')
Checkpoint.create!(:latitude => 38.918142, :longitude => -77.025635, :street_address => "American Ice", :name => "Lambda", :secret_code => 'lambda')
Checkpoint.create!(:latitude => 38.919244, :longitude => -77.041261, :street_address => "Marie Reed", :name => "Mu", :secret_code => 'mu')
Checkpoint.create!(:latitude => 38.909502, :longitude => -77.032673, :street_address => "Logan Hardware", :name => "Chi", :secret_code => 'chi')
Checkpoint.create!(:latitude => 38.895809, :longitude => -77.031541, :street_address => "Freedom Plaza", :name => "Sigma", :secret_code => 'sigma')
Checkpoint.create!(:latitude => 38.901093, :longitude => -77.045169, :street_address => "James Monroe", :name => "Psi", :secret_code => 'psi')
Checkpoint.create!(:latitude => 38.912457, :longitude => -77.038214, :street_address => "Dupont Italian Kitchen", :name => "Finish", :secret_code => 'finish', :is_finish => true)

# run some players through for testing
