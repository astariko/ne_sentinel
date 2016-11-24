class Branch < ActiveRecord::Base
  belongs_to :user

  	validates :name, presence: true, :uniqueness => true
  	validates :root, presence: true
end
