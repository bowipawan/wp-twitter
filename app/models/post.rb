class Post < ApplicationRecord
  belongs_to :user
  validates(:msg, presence: true)
  has_many :likes

  def get_likers
    # return self.likes.map{ |like| like.user.name }.join(" ")
    # return User.where(:id => self.likes.pluck('user_id')).pluck('name').join(" ")
    return self.likes.joins(:user).pluck('name').join(" ")
  end
end
