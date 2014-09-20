class ApiController < ApplicationController

  def nexmo_receiver

	puts params

	# require 'slack/post'
	# Slack::Post.configure(
	#   subdomain: 'hackerparadise2014',
	#   token: 'PmeYLdrdKKyRiVy0B5ckQXum',
	#   username: 'marc'
	# )
 #  Slack::Post.post "@channel #{params[:text]}", '#hotel-announcements'


 require 'slack-notifier'

notifier = Slack::Notifier.new "hackerparadise2014", "#{ENV['SLACK_TOKEN']}"
notifier.ping "<!channel> #{params[:text]}", channel: "#general", icon_url: 'http://cdn.graphicsfactory.com/clip-art/image_files/image/7/708587-dancing020yy.gif'


	render text: params
  end

end
