class User < ApplicationRecord
	has_secure_password
	has_many :posts
	validates(:email, length: {minimum: 2}, uniqueness: true)
	validates(:name, length: {minimum: 2}, uniqueness: true)
	validates(:password, length: {minimum: 8})
	has_many :followee, class_name: 'Follow', foreign_key: 'followee_id'
	has_many :follower, class_name: 'Follow', foreign_key: 'follower_id'
	validates_confirmation_of :password
	has_many :likes

	def get_feed_post
		return Post.where(:user_id => Follow.where(follower_id:id).pluck('followee_id')).order("created_at DESC")
	end
end
