class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :alias

  validates :vote_type, inclusion: { in: ["like", "dislike"] }
end
