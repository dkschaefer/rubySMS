def account_info()
	# get the users account info
	print "\n=>  Note: Your 'Account SID' and 'Auth Token' can be found on the Twilio.com user dashboard\n\n"
	print "[*] Enter your Account SID: "
	$accountsid = gets.chomp # Twilio Account SID 
	print "[*] Enter your Auth Token: "
	$authtoken = gets.chomp #Twilio Auth Token
	print "[*] Enter your Twilio phone number: "
	$sender = "+1"+gets.chomp
end

def prep_and_send()
	# target number, enter message, and send!
	print "[*] Enter the number you want to Text: "
	$recipient = "+1"+gets.chomp
	print "[*] Enter your message: "
	$message = gets.chomp

	client = Twilio::REST::Client.new($accountsid, $authtoken)
	client.account.sms.messages.create(
		:from => $sender,
		:to => $recipient,
		:body => $message,
		)

	print "\n\n=> Message sent! :)"
	print "\n*****************************"
	print "\nFrom:=> "+$sender
	print "\nTo  :=> "+$recipient
	print "\nMsg :=> "+$message
	print "\n*****************************"
	print "\n\n[*] Send another message? (Y/N): "
	again = gets.chomp
	again.downcase
	
	if again != "y"
		abort "\nGoodbye!"
	else
		print "\n"
		prep_and_send()
	end
end



print "\n[*] Checking for twilio-ruby... "
begin
	gem "twilio-ruby"
rescue LoadError
	system("gem install twilio-ruby")
	Gem.clear_paths
end
require "twilio-ruby"
print "OK!\n"

#continue program since they have the gem
print "\n Welcome to RubySMS!\n"
print "+-=-=-=-=-=-=-=-=-=+"
print "\n\nWould you like to send a Text message to a cell phone? (Y/N): "

continue = gets.chomp
continue.downcase!

if continue != "y"
	abort "[*] Quitting... Bye :)"	
else
	account_info()
	prep_and_send()	
end
