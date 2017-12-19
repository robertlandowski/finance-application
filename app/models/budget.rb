class Budget < ActiveRecord::Base
  belongs_to :user

  validates :user, uniqueness: { scope: :user_id, message: "Only one goal allowed!" }
end
