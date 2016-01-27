class Review < ActiveRecord::Base 
  belongs_to :user
  belongs_to :song 
  validates :song_id , uniqueness: { scope: :user_id , message: "Can only Reveiw Once!!" }

end
