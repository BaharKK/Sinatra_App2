class User < ActiveRecord::Base
  has_many :songs  
  has_many :votes
  has_many :reviews 
  validates :username, presence: true, uniqueness: true 

  def has_upvoted?(song) 
    self.votes.any? do |vote| 
      vote.song_id  == song.id 
    end
  end

  def has_reviewed?(song)
    self.reviews.any? do |review|
      review.song_id == song.id 
    end
  end
end