class Post < ActiveRecord::Base
  validates :title, :link, :description, presence: true
end
