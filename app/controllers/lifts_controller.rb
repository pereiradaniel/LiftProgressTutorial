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

  def destroy
    @lift = Lift.find(params[:id])
    @lift.destroy
    head :no_content
  end

  def update
    @lift = Lift.find(params[:id])
    if @lift.update(lift_params)
      render json: @lift
    else
      render json: @lift.errors, status: :unprocessable_entity
    end
  end

  private
  def lift_params
    params.require(:lift).permit(:date, :liftname, :ismetric, :weightlifted, :repsperformed, :onerm)
  end
end
