class Post < ApplicationRecord
  belongs_to :user
  validates(:msg, presence: true)
  has_many :likes

  def get_likers
    return self.likes.map{ |like| like.user.name }.join(" ")
  end
end
