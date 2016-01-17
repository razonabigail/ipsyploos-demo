class ProcessingController < ApplicationController
  def index

  	user_id = "ipsy-user-#{current_user.id}"
	url = params[:url]
	offer_id = params[:offer_id]
	tracking_url = ""

	# postback
	if params[:shop] == "Dummy Advertiser 2"
		tracking_url = "http://ipsyresearch.go2cloud.org/aff_c?offer_id=#{offer_id}&aff_id=1&user_id=#{user_id}"
	end

	# iframecode
	if params[:shop] == "Dummy Advertiser 3"
		#cookies[:user_id] = user_id
		#cookies[:offer_id] = offer_id
		cookies[:postbackurl] = "http://ipsyresearch.go2cloud.org/aff_lsr?aff_id=1&offer_id=#{offer_id}&user_id=#{user_id}&amount=AMOUNT&adv_sub2=PRODUCT"
		tracking_url = url
	end

	puts "[DEBUG] user_id: #{user_id}"
	puts "[DEBUG] offer_id: #{offer_id}"
	puts "[DEBUG] shop: #{params[:shop]}"
	puts "[DEBUG] Tracking URL: #{tracking_url}"

	redirect_to tracking_url

  end
end
