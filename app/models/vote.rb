class Vote < ActiveRecord::Base
  belongs_to :song
  belongs_to :user
  validates :song_id , uniqueness: { scope: :user_id, message: "Can be UpVoted Only Once!!"}
end