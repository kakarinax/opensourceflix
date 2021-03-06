class Favorite < ApplicationRecord
  belongs_to :favoritable, polymorphic: true
  belongs_to :user
  validates :user_id,
            uniqueness: { scope: %i[favoritable_type favoritable_id],
                          message: 'can favoritate only one time per resource' }
end
