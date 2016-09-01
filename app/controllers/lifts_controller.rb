class LiftsController < ApplicationController
  def create
    @lift = Lift.new(lift_params)

    if @lift.save
      render json: @lift
    else
      render json: @lift.errors, status: :unprocessable_entity
    end
  end

	def index
		@lifts = Lift.all
	end

  private
  def lift_params
    params.require(:lift).permit(:date, :liftname, :ismetric, :weightlifted, :repsperformed, :onerm)
  end
end
