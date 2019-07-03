
# msg = {text: '📢 Reminder to submit your timesheet by EOD
# https://compass.esa.cognizant.com', chat_id: '-19832692'}
require 'telegram_bot'
require './emoji_code'
require './calendar'
include EmojiCode, Calendar


calendar_array = dates_array.unshift(['Mon','Tue','Wed','Thu','Fri','Sat','Sun'])

p emoji['smile']

BOT_TOKEN = 'token'

bot = TelegramBot.new(token: BOT_TOKEN)

bot.get_updates(fail_silently: true) do |message|
  puts message.inspect
  puts message.chat.inspect
  puts message.chat.id.inspect
	puts "@#{message.from.username}: #{message.text}"
	command = message.get_command_for(bot)

	message.reply do |reply|
    puts reply.class
		case command
		when /start/i
			reply.text = "#{emoji['information_desk']} #{message.from.first_name}!  #{emoji['smile']}"
      reply.reply_markup = TelegramBot::ReplyKeyboardMarkup.new(
          keyboard: calendar_array,
          one_time_keyboard: true,
          resize_keyboard: true
      )
		when /hi/i
			reply.text = "#{emoji['information_desk']} #{message.from.first_name}!  #{emoji['smile']}"
      reply.reply_markup = TelegramBot::ReplyKeyboardMarkup.new(
          keyboard: [
              ["Enter leaves #{emoji['calendar']}", "Check leaves #{emoji['clipboard']}"],
          ],
          # selective: true,
          one_time_keyboard: true,
          resize_keyboard: true
      )
    when /Check leaves/i
      reply.text = "Hello #{message.from.first_name}!, feature in-progress #{emoji['see-no-evil-monkey']}"
      reply.reply_markup = TelegramBot::ReplyKeyboardMarkup.new(
        keyboard: [
          ['December', 'November']
        ],
        # selective: true,
        one_time_keyboard: true,
        resize_keyboard: true
      )
    when /Enter leaves/i
      reply.text = "select leave type"
      reply.reply_markup = TelegramBot::ReplyKeyboardMarkup.new(
        keyboard: [
          ["Overseas Leave #{emoji['airplane']}", "Not well #{emoji['syringe']}"]
        ],
        # selective: true,
        one_time_keyboard: true,
        resize_keyboard: true
      )
    when /Overseas Leave|Not well/i
      reply.text = "select no of days"
      reply.reply_markup = TelegramBot::ReplyKeyboardMarkup.new(
        keyboard: [
          ['1', '2', '3'],
          ['4', '5', '6']
        ],
        # selective: true,
        one_time_keyboard: true,
        resize_keyboard: true
      )
    when /\d/i
      reply.text = "Thanks #{message.from.username}"
      reply.reply_markup = TelegramBot::ReplyKeyboardHide.new()
		else
			reply.text = "#{message.from.first_name}, Are you OK baby. I have no idea what #{command.inspect} means."
		end
		puts "sending #{reply.text.inspect} to @#{message.from.username}"
    puts reply.inspect

		reply.send_with(bot)
	end
end
