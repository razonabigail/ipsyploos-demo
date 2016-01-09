class ProcessingController < ApplicationController
  def index
  	shop = params[:shop]
  	creative_id = params[:creative_id]
  	user_id = current_user.id
  	#exec "curl http://strk.cakemarketing.com/?a=#{user_id}&c=#{creative_id}&p=f&s1="
  	#exec "curl http://strk.cakemarketing.com/?a=5755&c=1442&p=f&s1=Sample+Product_ID&s2=Sample+Price"
  	redirect_to "http://www.#{shop}.com"
  end
end
