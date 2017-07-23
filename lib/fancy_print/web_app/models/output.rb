class Output < ActiveRecord::Base
  validates_presence_of :data, :datatype, :datetime
end
