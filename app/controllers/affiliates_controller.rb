class AffiliatesController < ApplicationController
  def index
  	
  end

  def new
  	@affiliate = Affiliate.new
  end

  def create
  	@affiliate = Affiliate.new(post_params)
  	if @affiliate.save
  		redirect_to @affiliate
  	else
  		render 'new'
  	end
  end

  def show
  	@affiliate = Affiliate.find(params[:id])
  end

  private
  def post_params
  	params.require(:affiliate).permit(:user_id, :lastname, :firstname, :email)
  end
end
