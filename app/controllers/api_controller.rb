class ApiController < ApplicationController

  def nexmo_receiver

	# puts params

	require 'slack-notifier'

	notifier = Slack::Notifier.new "hackerparadise2014", "#{ENV['SLACK_TOKEN']}"

	notifier.username = 'El Sueno Tropical'

	response = notifier.ping "<!channel> TESTING", channel: "#TESTING", icon_url: 'http://cdn.graphicsfactory.com/clip-art/image_files/image/7/708587-dancing020yy.gif'

	render text: params
  end

end
