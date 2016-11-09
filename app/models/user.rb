class User < ActiveRecord::Base
	has_many :nes, dependent: :destroy
end
