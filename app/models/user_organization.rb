class UserOrganization < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :user_id, presence: true, uniqueness: { scope: :organization, message: "should only join an organization once" }
  validates :organization_id, presence: true
end
