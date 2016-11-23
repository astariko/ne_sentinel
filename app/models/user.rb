class User < ActiveRecord::Base
	has_many :nes, dependent: :destroy
	has_many :branches, dependent: :destroy
end
