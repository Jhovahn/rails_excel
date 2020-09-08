require 'roo'

namespace :import do
  desc "import user data"
  task user: :environment do
    spreadsheet = Roo::Spreadsheet.open('data.xlsx').sheet('Users')

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

  desc "import company data"
  task company: :environment do
    companies = Roo::Spreadsheet.open('data.xlsx').sheet('Companies')

    headers = companies.row(1)

    companies.each_with_index do |row, idx|
      next if idx == 0
      company_data = Hash[[headers, row].transpose]
      puts company_data

      if Company.exists?(name: company_data['name'])
        puts "skipping company_data['name'] since already exists"
        next
      end

      company = Company.new(company_data)
      company.save!
    end
  end
end
