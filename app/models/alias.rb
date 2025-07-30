class Alias < ApplicationRecord
  belongs_to :user, optional: true
  has_many :votes, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :description, presence: true
  validates :code, presence: true
  validate :code_must_be_git_command

  before_save :remove_git_prefix_from_code

  # Search scope - database agnostic case-insensitive search
  scope :search, ->(query) {
    if query.present?
      # Use LOWER() for case-insensitive search that works across databases
      # Fully qualify column names to avoid ambiguity when joining with other tables
      sanitized_query = "%#{query.downcase}%"
      where("LOWER(aliases.name) LIKE ? OR LOWER(aliases.description) LIKE ? OR LOWER(aliases.code) LIKE ?",
            sanitized_query, sanitized_query, sanitized_query)
    else
      all
    end
  }

  scope :tagged_with, ->(tag_names) {
    if tag_names.present?
      joins(:tags).where(tags: { name: tag_names })
    else
      all
    end
  }

  def display_code
    stored_code = read_attribute(:code)
    stored_code.present? ? "git #{stored_code}" : ""
  end

  def likes_count
    votes.where(vote_type: "like").count
  end

  def dislikes_count
    votes.where(vote_type: "dislike").count
  end

  def score
    likes_count - dislikes_count
  end

  def user_vote(user)
    return nil unless user
    votes.find_by(user: user)
  end

  def can_user_edit_alias?(user)
    user == self.user
  end

  def ip_vote(ip_address)
    return nil unless ip_address
    votes.find_by(ip_address: ip_address, user_id: nil)
  end

  def tag_list
    tags.pluck(:name).join(", ")
  end

  def tag_list=(names)
    tag_names = names.split(",").map(&:strip).reject(&:blank?)
    self.tags = tag_names.map { |name| Tag.find_or_create_by_name(name) }
  end

  def remove_git_prefix_from_code
    self.code = self.code.sub(/^git /, "") || ""
  end

  private

  def code_must_be_git_command
    return if code.blank?

    # Remove git prefix for validation if present
    cleaned_code = code.sub(/^git /, "")

    # Check if it starts with ! which indicates shell command
    if cleaned_code.start_with?("!")
      errors.add(:code, "cannot contain shell commands (commands starting with !)")
    end

    true
  end
end
