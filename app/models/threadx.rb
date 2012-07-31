class Threadx < ActiveRecord::Base

	has_many :media_threadxes
	has_many :media, :through => :media_threadxes

	belongs_to :owner, :class_name => "User"

	has_many :threadx_collaborators
	has_many :users, :through => :threadx_collaborators

	has_many :codes

	has_many :threadx_images
	has_many :images, :through => :threadx_images
	
	has_many :highlighted_areas

	validates :thread_display_name, :start_date, :end_date, :description , :category, :presence => true
	
	validate :existing_thread

	def existing_thread
		current_user = User.find owner_id
		unless (current_user.owned_threads.find_by_thread_display_name thread_display_name) == nil
			errors.add(:thread_display_name, "is already exist")
		end
	end

end
