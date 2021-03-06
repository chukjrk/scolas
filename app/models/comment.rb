class Comment < ActiveRecord::Base
  validates_presence_of :comment
  belongs_to :post
  belongs_to :user
  has_many :replies
end
