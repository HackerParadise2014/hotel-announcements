class ApiController < ApplicationController

# do not request authenticity token for slack_receiver
protect_from_forgery except: :slack_receiver

  def nexmo_receiver

  	puts 'start nexmo_receiver'

	require 'slack-notifier'

	# production env notifications
	notifier = Slack::Notifier.new "#{ENV['SLACK_DOMAIN']}", "#{ENV['SLACK_TOKEN']}"

	notifier.username = 'El Sueno Tropical'

	response = notifier.ping "<!channel> #{params[:text]} [to reply via SMS include @sueno in your message]", channel: "#{ENV['SLACK_CHANNEL']}", icon_url: 'http://cdn.graphicsfactory.com/clip-art/image_files/image/7/708587-dancing020yy.gif'

	# we need to store the number of the most recent sender
	s = Sender.new
	s.phone = params[:msisdn]
	s.sent = false
	s.save

	render text: "end of nexmo_receiver"



  end

  def slack_receiver

  	# this is where the incoming webhook from slack sends messages
  	# the message content will be in params[:text]

  	# we need to take this text and sent it via nexmo to the number of the most recent sender
  	# note: according to the slack integration, this url will only be called if the message contains the keyword "sueno"

  	puts 'start slack receiver'

  	s = Sender.last
  	most_recent_num = s.phone

  	puts "params are: #{params}"

	puts 'do the sending'

  	require 'nexmo'

	nexmo = Nexmo::Client.new(key: ENV['NEXMO_KEY'], secret: ENV['NEXMO_SECRET'])

	if(params[:text])
		nexmo.send_message(from: ENV['NEXMO_FROM_NUMBER'], to: most_recent_num, text: params[:text])
	end

	# and also update the Sender to indicate that it received a reply, so we don't send any more to them.
	s.sent = true
	s.save
	

  	render text: params

  end


end
