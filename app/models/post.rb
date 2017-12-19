class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

   validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
   validates :topic, presence: true
   validates :user, presence: true
end
