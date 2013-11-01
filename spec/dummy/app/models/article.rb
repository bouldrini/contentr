class Article < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body

  permitted_attributes :title, :body
end
