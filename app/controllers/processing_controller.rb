class ProcessingController < ApplicationController
  def index

  	user_id = "ipsy-user-#{current_user.id}"
	offer_id = params[:offer_id]#"15" # dummy offer for dummy advertiser

	puts "[DEBUG] user_id: #{user_id}"
	puts "[DEBUG] offer_id: #{offer_id}"

	# Generate Unique URL
	tracking_url = "http://ipsyresearch.go2cloud.org/aff_c?offer_id=#{offer_id}&aff_id=1&user_id=#{user_id}"
	puts "[DEBUG] Tracking URL: #{tracking_url}"

	redirect_to tracking_url

  end
end
