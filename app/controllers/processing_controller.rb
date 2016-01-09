class ProcessingController < ApplicationController
  def index

	api_key = 'wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC'

  	#creative_id = params[:creative_id]
  	user_id = "ipsy-user-#{current_user.id}"

	puts "[DEBUG] user_id: #{user_id}"

	# Create New Affiliate
	affiliate_id = "0" # 0 to create a new affiliate
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
	puts "[DEBUG] Created Affiliate id: #{affiliate_id}"

######### START Supposed to be done only once
=begin
	# Create New Shop
  	shop_name = "ipsy-shopping-#{params[:shop]}"
	advertiser_id = "0"
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

=begin
OUTPUT FROM SERVER
[DEBUG] user_id: ipsy-user-1
[DEBUG] create Affiliate url: http://sandbox.cakemarketing.com/api/2/addedit.asmx/Affiliate?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&affiliate_id=0&affiliate_name=ipsy-user-1&third_party_name=third_party&account_status_id=1&inactive_reason_id=0&affiliate_tier_id=0&account_manager_id=0&hide_offers=FALSE&website=http%3A%2F%2Fpeppaexample.com&tax_class=Corporation&ssn_tax_id=123456789&vat_tax_required=FALSE&swift_iban=12321321&payment_to=0&payment_fee=0&payment_min_threshold=1500&currency_id=1&payment_setting_id=1&billing_cycle_id=2&payment_type_id=4&payment_type_info=Here+is+some+payment+information+that+willl+allow+me+to+get+paid&address_street=123+Main+Street&address_street2=suite+250&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&media_type_ids=13%2C8&price_format_ids=1%2C2%2C3&vertical_category_ids=11%2C6%2C12&country_codes=US%2CCA&tags=NULL&pixel_html=%3Ciframe+src%3D%22http%3A%2F%2Fdemotrk.cakemarketing.com%2Fp.ashx%3Fo%3D197%26t%3DTRANSACTION_ID%22+height%3D%221%22+width%3D%221%22+frameborder%3D%220%22%3E%3C%2Fiframe%3E&postback_url=&postback_delay_ms=0&fire_global_pixel=False&date_added=10%2F24%2F2006&online_signup=FALSE&signup_ip_address=&referral_affiliate_id=0&referral_notes=0&terms_and_conditions_agreed=TRUE&notes=Specialize+in+CPC+traffic
[DEBUG] Created Affiliate id: 5775
[DEBUG] create Advertiser url: http://sandbox.cakemarketing.com/api/1/addedit.asmx/Advertiser?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&advertiser_id=0&advertiser_name=ipsy-shopping-sephora&third_party_name=Integrate+an+external+system&account_status_id=1&online_signup=FALSE&signup_ip_address=&website=http://google.com&billing_cycle_id=3&account_manager_id=0&address_street=123_main_street&address_street2=&address_city=Fullerton&address_state=CA&address_zip_code=92831&address_country=US&notes=Open_Text&tags=
[DEBUG] Created Advertiser id: 56
[DEBUG] create Offer url: http://sandbox.cakemarketing.com/api/5/addedit.asmx/Offer?api_key=wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC&offer_id=0&advertiser_id=56&vertical_id=1&offer_name=ipsy-offer-Big-Big-Discount&third_party_name=third_party&offer_status_id=1&offer_type_id=3&currency_id=1&ssl=off&click_cookie_days=30&impression_cookie_days=30&enable_view_thru_conversions=off&click_trumps_impression=off&disable_click_deduplication=off&last_touch=off&enable_transaction_id_deduplication=off&offer_contract_name=Offer+Contract+1&price_format_id=1&payout=3.25&received=4.35&received_percentage=off&offer_link=http://getCAKE.com&thankyou_link=http://getCAKE.com/thankyou&offer_contract_hidden=off&preview_link=http://getCAKE.com&offer_description=Hot+new+sneakers+for+you&restrictions=Only+for+sneakers,+not+sandals&advertiser_extended_terms=Must+be+a+human+to+run+Offer&testing_instructions=Use+a+fake+CC&tags=tagged&hidden=off&redirect_offer_contract_id=0&redirect_404=off&postbacks_only=off&pixel_html=&postback_url=&postback_url_ms_delay=0&fire_global_pixel=off&fire_pixel_on_non_paid_conversions=off&static_suppression=1&conversion_cap_behavior=0&conversion_behavior_on_redirect=0&expiration_date=12/31/2014%2013:59:59&expiration_date_modification_type=do_not_change&thumbnail_file_import_url=&allow_affiliates_to_create_creatives=off&unsubscribe_link=&from_lines=&subject_lines=&conversions_from_whitelist_only=off&allowed_media_type_modification_type=do_not_change&allowed_media_type_ids=&redirect_domain=&cookie_domain=&track_search_terms_from_non_supported_search_engines=off&auto_disposition_type=none&auto_disposition_delay_hours=0&session_regeneration_seconds=-1&session_regeneration_type_id=0&payout_modification_type=change&received_modification_type=change&tags_modification_type=do_not_change
[DEBUG] Created Offer id: 411
[DEBUG] Created Campaign id: 2823
[DEBUG] Created Creative id: 1444
[DEBUG] Created UNIQUE URL: http://strk.cakemarketing.com/?a=ipsy-user-1&c=1444&p=f&s1=
Rendered processing/index.html.erb within layouts/application (2.7ms)
=end
######### END

	# The advertiser ID, offer ID, and Creative ID should be stored to ipsyploos database

	#TODO hardcoded for sephora
	creative_id = "1444"

	# Generate Unique URL
  	url = "http://strk.cakemarketing.com/?a=#{user_id}&c=#{creative_id}&p=f&s1="
	puts "[DEBUG] Created UNIQUE URL: #{url}"

	# encode the Unique URL to send as parameter to the redirect site
	require 'cgi'
	encoded_url = CGI.escape(url)
	puts "[DEBUG] Encoded UNIQUE URL: #{encoded_url}"

	# something to decode the URL
	decoded_url = CGI.unescape(encoded_url)
	puts "[DEBUG] Decoded UNIQUE URL: #{decoded_url}"
	

  	#redirect_to "http://www.#{shop}.com"
  end
end
