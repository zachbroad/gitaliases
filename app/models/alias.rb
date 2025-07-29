class Alias < ApplicationRecord
  belongs_to :user, optional: true
  has_many :votes, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :code, presence: true


  def likes_count
    votes.where(vote_type: "like").count
  end

  def dislikes_count
    votes.where(vote_type: "dislike").count
  end

  def score
    return likes_count - dislikes_count
  end

  def user_vote(user)
    return nil unless user
    votes.find_by(user: user)
  end

end
