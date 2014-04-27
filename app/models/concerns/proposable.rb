module Proposable
	include ActiveSupport::Concern

	include do
		include OwnerShip::Dual
		include Ownership::Session
	end

	module ClassMethods
	end
end