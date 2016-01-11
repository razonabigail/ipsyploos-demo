class ProcessingController < ApplicationController
  def index

	api_key = 'wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC'

  	#creative_id = params[:creative_id]
  	user_id = "ipsy-user-#{current_user.id}"
	puts "[DEBUG] user_id: #{user_id}"

	# initialize
	affiliate_id = "0"
	advertiser_id = "0"
	offer_id = "0"
	creative_id = "0"

	
	# TODO affiliate_id should be queried from the database

	# TODO advertiser_id, creative_id, offer_id should be queried from the database


	# STATIC PARAMS FOR TESTING ONLY
	affiliate_id = "1"
	creative_id = "98"	

	if "#{params[:shop]}" == "sephora"
		advertiser_id = "56"
		offer_id = "411"
		creative_id = "1444"
	elsif "#{params[:shop]}" == "maccosmetics"
		advertiser_id = "57"
		offer_id = "412"
		creative_id = "1445"
	elsif "#{params[:shop]}" == "avon"
		advertiser_id = "58"
		offer_id = "413"
		creative_id = "1446"
	end


	# Create New Affiliate if an affiliate_id is not yet found in the database
	if affiliate_id == "0"
		t0 = Time.now
		url = "http://sandbox.cakemarketing.com/api/2/addedit.asmx/Affiliate?api_key=#{api_key}&affiliate_id=#{affiliate_id}&affiliate_name=#{user_id}&third_party_name=third_party&account_status_id=1&inactive_reason_id=0&affiliate_tier_id=0&account_manager_id=0&hide_offers=FALSE&website=http%3A%2F%2Fpeppaexample.com&tax_class=Corporation&ssn_tax_id=123456789&vat_tax_required=FALSE&swift_iban=12321321&payment_to=0&payment_fee=0&payment_min_threshold=1500&currency_id=1&payment_setting_id=1&billing_cycle_id=2&payment_type_id=4&payment_type_info=Here+is+some+payment+information+that+willl+allow+me+to+get+paid&address_street=123+Main+Street&address_street2=suite+250&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&media_type_ids=13%2C8&price_format_ids=1%2C2%2C3&vertical_category_ids=11%2C6%2C12&country_codes=US%2CCA&tags=NULL&pixel_html=%3Ciframe+src%3D%22http%3A%2F%2Fdemotrk.cakemarketing.com%2Fp.ashx%3Fo%3D197%26t%3DTRANSACTION_ID%22+height%3D%221%22+width%3D%221%22+frameborder%3D%220%22%3E%3C%2Fiframe%3E&postback_url=&postback_delay_ms=0&fire_global_pixel=False&date_added=10%2F24%2F2006&online_signup=FALSE&signup_ip_address=&referral_affiliate_id=0&referral_notes=0&terms_and_conditions_agreed=TRUE&notes=Specialize+in+CPC+traffic" # default parameters
		puts "[DEBUG] create Affiliate url: #{url}"

		# send request and get response from CAKE
		require 'nokogiri'
		require 'open-uri'
		xml = Nokogiri::XML(open(url))
		if xml.search('success').text == "false"
			puts "ERROR: cannot create new affiliate"
			return
		end
		affiliate_id = xml.search('affiliate_id').text
		puts "[DEBUG] Created Affiliate id: #{affiliate_id} after #{Time.now-t0} seconds"

		# TODO affiliate_id  should be stored to the database

	end


	# Create advertiser_id, offer_id, creative_id if they are not yet found in the database
	if advertiser_id == "0"
		t0 = Time.now
		# Create New Shop
		shop_name = "ipsy-shopping-#{params[:shop]}"
		url = "http://sandbox.cakemarketing.com/api/1/addedit.asmx/Advertiser?api_key=#{api_key}&advertiser_id=#{advertiser_id}&advertiser_name=#{shop_name}&third_party_name=Integrate+an+external+system&account_status_id=1&online_signup=FALSE&signup_ip_address=&website=http://google.com&billing_cycle_id=3&account_manager_id=0&address_street=123_main_street&address_street2=&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&notes=Open_Text&tags="
		puts "[DEBUG] create Advertiser url: #{url}"
		xml = Nokogiri::XML(open(url))
		if xml.search('success').text == "false"
			puts "ERROR: cannot create new advertiser"
			return
		end
		advertiser_id = xml.search('advertiser_id').text
		puts "[DEBUG] Created Advertiser id: #{advertiser_id}"

		# create Offer
		offer_id = "0"
		offer_name = "ipsy-offer-Big-Big-Discount"
		url = "http://sandbox.cakemarketing.com/api/5/addedit.asmx/Offer?api_key=#{api_key}&offer_id=#{offer_id}&advertiser_id=#{advertiser_id}&vertical_id=1&offer_name=#{offer_name}&third_party_name=third_party&offer_status_id=1&offer_type_id=3&currency_id=1&ssl=off&click_cookie_days=30&impression_cookie_days=30&enable_view_thru_conversions=off&click_trumps_impression=off&disable_click_deduplication=off&last_touch=off&enable_transaction_id_deduplication=off&offer_contract_name=Offer+Contract+1&price_format_id=1&payout=3.25&received=4.35&received_percentage=off&offer_link=http://getCAKE.com&thankyou_link=http://getCAKE.com/thankyou&offer_contract_hidden=off&preview_link=http://getCAKE.com&offer_description=Hot+new+sneakers+for+you&restrictions=Only+for+sneakers,+not+sandals&advertiser_extended_terms=Must+be+a+human+to+run+Offer&testing_instructions=Use+a+fake+CC&tags=tagged&hidden=off&redirect_offer_contract_id=0&redirect_404=off&postbacks_only=off&pixel_html=&postback_url=&postback_url_ms_delay=0&fire_global_pixel=off&fire_pixel_on_non_paid_conversions=off&static_suppression=1&conversion_cap_behavior=0&conversion_behavior_on_redirect=0&expiration_date=12/31/2014%2013:59:59&expiration_date_modification_type=do_not_change&thumbnail_file_import_url=&allow_affiliates_to_create_creatives=off&unsubscribe_link=&from_lines=&subject_lines=&conversions_from_whitelist_only=off&allowed_media_type_modification_type=do_not_change&allowed_media_type_ids=&redirect_domain=&cookie_domain=&track_search_terms_from_non_supported_search_engines=off&auto_disposition_type=none&auto_disposition_delay_hours=0&session_regeneration_seconds=-1&session_regeneration_type_id=0&payout_modification_type=change&received_modification_type=change&tags_modification_type=do_not_change"
		puts "[DEBUG] create Offer url: #{url}"
		xml = Nokogiri::XML(open(url))
		if xml.search('success').text == "false"
			puts "ERROR: cannot create new offer"
			return
		end
		offer_id = xml.search('offer_id').text
		puts "[DEBUG] Created Offer id: #{offer_id}"

		campaign_id = xml.search('campaign_id').text
		puts "[DEBUG] Created Campaign id: #{campaign_id}"

		creative_id = xml.search('creative_id').text
		puts "[DEBUG] Created Creative id: #{creative_id}"
		puts "creating advertiser and offer after #{Time.now-t0} seconds"
		
		# TODO The advertiser ID, offer ID, and Creative ID should be stored to ipsyploos database

	end


=begin OUTPUT LOGS
SEPHORA
[DEBUG] create Advertiser url: http://sandbox.cakemarketing.com/api/1/addedit.asmx/Advertiser?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&advertiser_id=0&advertiser_name=ipsy-shopping-sephora&third_party_name=Integrate+an+external+system&account_status_id=1&online_signup=FALSE&signup_ip_address=&website=http://google.com&billing_cycle_id=3&account_manager_id=0&address_street=123_main_street&address_street2=&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&notes=Open_Text&tags=
[DEBUG] Created Advertiser id: 56
[DEBUG] create Offer url: http://sandbox.cakemarketing.com/api/5/addedit.asmx/Offer?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&offer_id=0&advertiser_id=56&vertical_id=1&offer_name=ipsy-offer-Big-Big-Discount&third_party_name=third_party&offer_status_id=1&offer_type_id=3&currency_id=1&ssl=off&click_cookie_days=30&impression_cookie_days=30&enable_view_thru_conversions=off&click_trumps_impression=off&disable_click_deduplication=off&last_touch=off&enable_transaction_id_deduplication=off&offer_contract_name=Offer+Contract+1&price_format_id=1&payout=3.25&received=4.35&received_percentage=off&offer_link=http://getCAKE.com&thankyou_link=http://getCAKE.com/thankyou&offer_contract_hidden=off&preview_link=http://getCAKE.com&offer_description=Hot+new+sneakers+for+you&restrictions=Only+for+sneakers,+not+sandals&advertiser_extended_terms=Must+be+a+human+to+run+Offer&testing_instructions=Use+a+fake+CC&tags=tagged&hidden=off&redirect_offer_contract_id=0&redirect_404=off&postbacks_only=off&pixel_html=&postback_url=&postback_url_ms_delay=0&fire_global_pixel=off&fire_pixel_on_non_paid_conversions=off&static_suppression=1&conversion_cap_behavior=0&conversion_behavior_on_redirect=0&expiration_date=12/31/2014%2013:59:59&expiration_date_modification_type=do_not_change&thumbnail_file_import_url=&allow_affiliates_to_create_creatives=off&unsubscribe_link=&from_lines=&subject_lines=&conversions_from_whitelist_only=off&allowed_media_type_modification_type=do_not_change&allowed_media_type_ids=&redirect_domain=&cookie_domain=&track_search_terms_from_non_supported_search_engines=off&auto_disposition_type=none&auto_disposition_delay_hours=0&session_regeneration_seconds=-1&session_regeneration_type_id=0&payout_modification_type=change&received_modification_type=change&tags_modification_type=do_not_change
[DEBUG] Created Offer id: 411
[DEBUG] Created Campaign id: 2823
[DEBUG] Created Creative id: 1444
[DEBUG] Created UNIQUE URL: http://strk.cakemarketing.com/?a=ipsy-user-1&c=1444&p=f&s1=
Rendered processing/index.html.erb within layouts/application (2.7ms)

MAC
[DEBUG] create Advertiser url: http://sandbox.cakemarketing.com/api/1/addedit.asmx/Advertiser?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&advertiser_id=0&advertiser_name=ipsy-shopping-mac&third_party_name=Integrate+an+external+system&account_status_id=1&online_signup=FALSE&signup_ip_address=&website=http://google.com&billing_cycle_id=3&account_manager_id=0&address_street=123_main_street&address_street2=&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&notes=Open_Text&tags=
[DEBUG] Created Advertiser id: 57
[DEBUG] create Offer url: http://sandbox.cakemarketing.com/api/5/addedit.asmx/Offer?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&offer_id=0&advertiser_id=57&vertical_id=1&offer_name=ipsy-offer-Big-Big-Discount&third_party_name=third_party&offer_status_id=1&offer_type_id=3&currency_id=1&ssl=off&click_cookie_days=30&impression_cookie_days=30&enable_view_thru_conversions=off&click_trumps_impression=off&disable_click_deduplication=off&last_touch=off&enable_transaction_id_deduplication=off&offer_contract_name=Offer+Contract+1&price_format_id=1&payout=3.25&received=4.35&received_percentage=off&offer_link=http://getCAKE.com&thankyou_link=http://getCAKE.com/thankyou&offer_contract_hidden=off&preview_link=http://getCAKE.com&offer_description=Hot+new+sneakers+for+you&restrictions=Only+for+sneakers,+not+sandals&advertiser_extended_terms=Must+be+a+human+to+run+Offer&testing_instructions=Use+a+fake+CC&tags=tagged&hidden=off&redirect_offer_contract_id=0&redirect_404=off&postbacks_only=off&pixel_html=&postback_url=&postback_url_ms_delay=0&fire_global_pixel=off&fire_pixel_on_non_paid_conversions=off&static_suppression=1&conversion_cap_behavior=0&conversion_behavior_on_redirect=0&expiration_date=12/31/2014%2013:59:59&expiration_date_modification_type=do_not_change&thumbnail_file_import_url=&allow_affiliates_to_create_creatives=off&unsubscribe_link=&from_lines=&subject_lines=&conversions_from_whitelist_only=off&allowed_media_type_modification_type=do_not_change&allowed_media_type_ids=&redirect_domain=&cookie_domain=&track_search_terms_from_non_supported_search_engines=off&auto_disposition_type=none&auto_disposition_delay_hours=0&session_regeneration_seconds=-1&session_regeneration_type_id=0&payout_modification_type=change&received_modification_type=change&tags_modification_type=do_not_change
[DEBUG] Created Offer id: 412
[DEBUG] Created Campaign id: 2824
[DEBUG] Created Creative id: 1445
creating advertiser and offer after 3.429690005 seconds

AVON
[DEBUG] create Advertiser url: http://sandbox.cakemarketing.com/api/1/addedit.asmx/Advertiser?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&advertiser_id=0&advertiser_name=ipsy-shopping-avon&third_party_name=Integrate+an+external+system&account_status_id=1&online_signup=FALSE&signup_ip_address=&website=http://google.com&billing_cycle_id=3&account_manager_id=0&address_street=123_main_street&address_street2=&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&notes=Open_Text&tags=
[DEBUG] Created Advertiser id: 58
[DEBUG] create Offer url: http://sandbox.cakemarketing.com/api/5/addedit.asmx/Offer?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&offer_id=0&advertiser_id=58&vertical_id=1&offer_name=ipsy-offer-Big-Big-Discount&third_party_name=third_party&offer_status_id=1&offer_type_id=3&currency_id=1&ssl=off&click_cookie_days=30&impression_cookie_days=30&enable_view_thru_conversions=off&click_trumps_impression=off&disable_click_deduplication=off&last_touch=off&enable_transaction_id_deduplication=off&offer_contract_name=Offer+Contract+1&price_format_id=1&payout=3.25&received=4.35&received_percentage=off&offer_link=http://getCAKE.com&thankyou_link=http://getCAKE.com/thankyou&offer_contract_hidden=off&preview_link=http://getCAKE.com&offer_description=Hot+new+sneakers+for+you&restrictions=Only+for+sneakers,+not+sandals&advertiser_extended_terms=Must+be+a+human+to+run+Offer&testing_instructions=Use+a+fake+CC&tags=tagged&hidden=off&redirect_offer_contract_id=0&redirect_404=off&postbacks_only=off&pixel_html=&postback_url=&postback_url_ms_delay=0&fire_global_pixel=off&fire_pixel_on_non_paid_conversions=off&static_suppression=1&conversion_cap_behavior=0&conversion_behavior_on_redirect=0&expiration_date=12/31/2014%2013:59:59&expiration_date_modification_type=do_not_change&thumbnail_file_import_url=&allow_affiliates_to_create_creatives=off&unsubscribe_link=&from_lines=&subject_lines=&conversions_from_whitelist_only=off&allowed_media_type_modification_type=do_not_change&allowed_media_type_ids=&redirect_domain=&cookie_domain=&track_search_terms_from_non_supported_search_engines=off&auto_disposition_type=none&auto_disposition_delay_hours=0&session_regeneration_seconds=-1&session_regeneration_type_id=0&payout_modification_type=change&received_modification_type=change&tags_modification_type=do_not_change
[DEBUG] Created Offer id: 413
[DEBUG] Created Campaign id: 2825
[DEBUG] Created Creative id: 1446
creating advertiser and offer after 3.264792307 seconds
=end
######### END

	


	# STATIC PARAMS FOR TESTING ONLY
	affiliate_id = "1"
	creative_id = "98"



	puts "[DEBUG] affiliate_id: #{affiliate_id}"
	puts "[DEBUG] shop: #{params[:shop]}"
	puts "[DEBUG] advertiser_id: #{advertiser_id}"
	puts "[DEBUG] offer_id: #{offer_id}"
	puts "[DEBUG] creative_id: #{creative_id}"

	# Generate Unique URL
  	cake_url = "http://strk.cakemarketing.com/?a=#{affiliate_id}&c=#{creative_id}&s1="
	puts "[DEBUG] Created UNIQUE URL: #{cake_url}"

	# encode the Unique URL to send as parameter to the redirect site
	require 'cgi'
	encoded_url = CGI.escape(cake_url)
	puts "[DEBUG] Encoded UNIQUE URL: #{encoded_url}"

	# PASS params to shop url
	shop_url = "http://localhost:3001"

	full_url = "#{shop_url}/mainpage?encoded_url=#{encoded_url}"

	puts "[DEBUG] Encoded FULL URL: #{full_url}"


	redirect_to full_url



  end
end
