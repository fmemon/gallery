class Album < ActiveRecord::Base
	has_many :albumizations, :dependent => :destroy, :order => "position"
	has_many :photos, :through => :albumizations, :uniq => true, :order => "position"
  
  def to_s    
    self.title  
  end

end
# == Schema Information
#
# Table name: albums
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

