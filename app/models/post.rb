class Post < ActiveRecord::Base
  validates_presence_of :message  
  validates_length_of :message, :minimum => 1
  belongs_to :user
  has_many :comments 
end
