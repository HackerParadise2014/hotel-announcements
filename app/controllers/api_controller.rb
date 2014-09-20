class ApiController < ApplicationController

  def nexmo_receiver

	puts params

	require 'slack/post'
	Slack::Post.configure(
	  subdomain: 'hackerparadise2014',
	  token: 'PmeYLdrdKKyRiVy0B5ckQXum',
	  username: 'marc'
	)
  Slack::Post.post "Domo arigato.", '#hotel-announcements'
	render text: params
  end

end
