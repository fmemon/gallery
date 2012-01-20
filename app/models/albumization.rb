class Albumization < ActiveRecord::Base
  belongs_to :photo
  belongs_to :album
end
# == Schema Information
#
# Table name: albumizations
#
#  id         :integer         not null, primary key
#  album_id   :integer
#  photo_id   :integer
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

