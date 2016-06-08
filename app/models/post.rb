class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, :link, :description, presence: true
end
