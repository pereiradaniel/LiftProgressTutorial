class LiftsController < ApplicationController
	def index
		@lifts = Lift.all
	end
end
