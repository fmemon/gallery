class Photo < ActiveRecord::Base
	has_many :albumizations, :dependent => :destroy
	has_many :albums, :through => :albumizations

has_attached_file :image, :styles => { :square => "75x75#",
                                       :thumb => "100x100>",
                                       :small => "240x240>",
                                       :medium => "500x500>",
                                       :large => "1024x1024>" } 
                                       
  after_save :update_albums 

	def album_ids=(ids) 
		if new_record? 
			@new_album_ids = ids.reject(&:blank?) 
		else 
			self.albumizations.each { |z| z.destroy unless ids.delete(z.album_id.to_s) } 
			ids.reject(&:blank?).each {|id| self.albumizations.create(:album_id => id) } 
		end 
	end 
	
	def album_ids 
		new_record? ? @new_album_ids : albums.map(&:id) 
	end 
	
	def self.orphaned 
		find(:all, :include => :albumizations).select {|p| p.albumizations.empty? } 
	end 
	
	def next(album=nil)     
		collection = album ? album.photos : self.class.find(:all)    
		collection.size == collection.index(self) + 1 ? collection.first : collection[ collection.index(self) + 1 ]  
	end   
	
	def previous(album=nil)     
		collection = album ? album.photos : self.class.find(:all)
		collection[ collection.index(self) - 1 ]  
	end
	
	private 
		def update_albums 
			self.album_ids = @new_album_ids if @new_album_ids
		end 
  
end
# == Schema Information
#
# Table name: photos
#
#  id                 :integer         not null, primary key
#  title              :string(255)
#  description        :text
#  taken_on           :date
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  created_at         :datetime
#  updated_at         :datetime
#

