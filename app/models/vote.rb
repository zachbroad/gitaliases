class Vote < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :alias

  validates :vote_type, inclusion: { in: [ "like", "dislike" ] }
  validates :ip_address, presence: true, unless: :user_id?

  # Either user_id or ip_address must be present, but not both for anonymous votes
  validate :user_or_ip_present

  private

  def user_or_ip_present
    if user_id.blank? && ip_address.blank?
      errors.add(:base, "Either user or IP address must be present")
    end
  end
end
