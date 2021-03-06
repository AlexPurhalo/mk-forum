class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, :link, :description, presence: true
  has_attached_file :image, styles: { medium: "700x550", small: "400x350" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  acts_as_votable
end

