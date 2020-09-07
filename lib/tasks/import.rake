require 'roo'

namespace :import do
  desc "import user data"
  task data: :environment do
    spreadsheet = Roo::Spreadsheet.open('users_file.xlsx').sheet('Users')

    headers = spreadsheet.row(1);

    spreadsheet.each_with_index do |row, idx|
      next if idx == 0
      user_data = Hash[[headers, row].transpose]
      puts user_data

      if User.exists?(email: user_data['email'])
        puts "User with email user_data['email'] already exists"
        next
      end

      user = User.new(user_data)

      puts "Saving User with email '#{user.email}'"
      user.save!
    end
  end
end
