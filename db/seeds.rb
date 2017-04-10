# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Background Processing => Sidekiq
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'add_reset_pk_sequence_to_base.rb'
Bill.delete_all
Bill.reset_pk_sequence
Expense.delete_all
Expense.reset_pk_sequence
Income.delete_all
Income.reset_pk_sequence
User.delete_all
User.reset_pk_sequence
ExpenseCategory.delete_all
ExpenseCategory.reset_pk_sequence
Listofvalue.delete_all
Listofvalue.reset_pk_sequence
ExpenseReference.delete_all
ExpenseReference.reset_pk_sequence
ExpenseDetail.delete_all
ExpenseDetail.reset_pk_sequence


MONTHS = [0, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
TYPE = ['Rent', 'Electric', 'Heat', 'TV', 'Internet', 'Groceries', 'Eating Out', 'Entertainment', 'Clothing', 'Transportation']
#User
User.create(email: "samtheman@yppf.com", state: "MA", name: "Sam", password: 'brandeis16', password_confirmation: 'brandeis16')

#List of Values
Listofvalue.create(lov_domain: "exp_ref_type",lov_key: 1,lov_value: 'Once')
Listofvalue.create(lov_domain: "exp_ref_type",lov_key: 2,lov_value: 'Every Month')
Listofvalue.create(lov_domain: "exp_ref_status",lov_key: 1,lov_value: 'Active')
Listofvalue.create(lov_domain: "exp_ref_status",lov_key: 2,lov_value: 'Inactive')

(1..12).each do |i|
  Listofvalue.create(lov_domain: "month",lov_key: i,lov_value: MONTHS[i])
end
(0..11).each do |i|
  Listofvalue.create(lov_domain: "year",lov_key: 2016+i,lov_value: (2016+i).to_s)
end
#Expense Categories
#exp_type 1=Expense, 2=Bill
(0..9).each do |i|
ExpenseCategory.create(exp_name: TYPE[i], id: i+1,exp_type: 1)
end
ExpenseCategory.create(exp_name: 'Phone Bill', id: 11,exp_type: 2)

#Expense Reference
#ref_type 1=Once, 2=Every Month
#Rent
ExpenseReference.create(ref_name: 'Home Rent',user_id: 1, ref_value: 1325,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 1)
ExpenseReference.create(ref_name: 'Home Rent',user_id: 1, ref_value: 1325,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 1)
ExpenseReference.create(ref_name: 'Home Rent',user_id: 1, ref_value: 1325,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 1)
ExpenseReference.create(ref_name: 'Home Rent',user_id: 1, ref_value: 1325,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 1)
ExpenseReference.create(ref_name: 'Home Rent',user_id: 1, ref_value: 1325,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 1)

#Electric
ExpenseReference.create(ref_name: 'Home Eversource',user_id: 1, ref_value: 45,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 2)
ExpenseReference.create(ref_name: 'Home Eversource',user_id: 1, ref_value: 50,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 2)
ExpenseReference.create(ref_name: 'Home Eversource',user_id: 1, ref_value: 40,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 2)
ExpenseReference.create(ref_name: 'Home Eversource',user_id: 1, ref_value: 35,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 2)
ExpenseReference.create(ref_name: 'Home Eversource',user_id: 1, ref_value: 25,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 2)
#Heat
ExpenseReference.create(ref_name: 'Home Heat',user_id: 1, ref_value: 70,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 3)
ExpenseReference.create(ref_name: 'Home Heat',user_id: 1, ref_value: 65,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 3)
ExpenseReference.create(ref_name: 'Home Heat',user_id: 1, ref_value: 50,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 3)
ExpenseReference.create(ref_name: 'Home Heat',user_id: 1, ref_value: 30,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 3)
ExpenseReference.create(ref_name: 'Home Heat',user_id: 1, ref_value: 10,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 3)
#Groceries
ExpenseReference.create(ref_name: 'Dog Food',user_id: 1, ref_value: 25,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dog Food',user_id: 1, ref_value: 29,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dog Food',user_id: 1, ref_value: 20,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dog Food',user_id: 1, ref_value: 30,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dog Food',user_id: 1, ref_value: 25,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dairy',user_id: 1, ref_value: 120,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dairy',user_id: 1, ref_value: 140,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dairy',user_id: 1, ref_value: 100,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dairy',user_id: 1, ref_value: 125,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 6)
ExpenseReference.create(ref_name: 'Dairy',user_id: 1, ref_value: 90,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 6)
#Eating Out
ExpenseReference.create(ref_name: 'Restaurant',user_id: 1, ref_value: 63,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Restaurant',user_id: 1, ref_value: 72,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Restaurant',user_id: 1, ref_value: 50,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Restaurant',user_id: 1, ref_value: 60,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Restaurant',user_id: 1, ref_value: 70,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Coffee Shop',user_id: 1, ref_value: 35,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Coffee Shop',user_id: 1, ref_value: 40,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Coffee Shop',user_id: 1, ref_value: 25,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Coffee Shop',user_id: 1, ref_value: 30,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 7)
ExpenseReference.create(ref_name: 'Coffee Shop',user_id: 1, ref_value: 25,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 7)
#Entertainment
ExpenseReference.create(ref_name: 'Cinema',user_id: 1, ref_value: 15,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Cinema',user_id: 1, ref_value: 20,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Cinema',user_id: 1, ref_value: 10,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Cinema',user_id: 1, ref_value: 20,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Cinema',user_id: 1, ref_value: 15,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Museum',user_id: 1, ref_value: 10,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Museum',user_id: 1, ref_value: 5,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Museum',user_id: 1, ref_value: 20,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Museum',user_id: 1, ref_value: 35,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 8)
ExpenseReference.create(ref_name: 'Museum',user_id: 1, ref_value: 25,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 8)
#Clothing
ExpenseReference.create(ref_name: 'Sport Clothes',user_id: 1, ref_value: 10,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Sport Clothes',user_id: 1, ref_value: 15,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Sport Clothes',user_id: 1, ref_value: 50,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Sport Clothes',user_id: 1, ref_value: 100,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Sport Clothes',user_id: 1, ref_value: 75,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Casual Clothes',user_id: 1, ref_value: 45,ref_type: 1,ref_status: 1,ref_month: 1,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Casual Clothes',user_id: 1, ref_value: 15,ref_type: 1,ref_status: 1,ref_month: 2,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Casual Clothes',user_id: 1, ref_value: 60,ref_type: 1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Casual Clothes',user_id: 1, ref_value: 50,ref_type: 1,ref_status: 1,ref_month: 4,ref_year: Date.today.year,expense_category_id: 9)
ExpenseReference.create(ref_name: 'Casual Clothes',user_id: 1, ref_value: 55,ref_type: 1,ref_status: 1,ref_month: 5,ref_year: Date.today.year,expense_category_id: 9)

(1..5).each do |i|
  exp1=Expense.where(user_id: 1,expense_reference_id: i)

  exp1.each do |exp|
  ExpenseDetail.create(expdet_date: DateTime.new(exp.year, exp.month, 2),expdet_value: exp.projvalue,user_id: 1,expense_id:exp.id,expdet_description: "it was fun.")
  end
end
(6..55).each do |i|
  exp1=Expense.where(user_id: 1,expense_reference_id: i)

  exp1.each do |exp|
    if exp.month!=Date.today.month || exp.year!=Date.today.year
      prcnt=(75..100)
    else
      prcnt=(20..75)
    end 
  ExpenseDetail.create(expdet_date: DateTime.new(exp.year, exp.month, 2),expdet_value: rand(prcnt)*exp.projvalue/100,user_id: 1,expense_id:exp.id,expdet_description: "it was fun.")
  end
end
#(0..9).each do |i|
#ExpenseReference.create(ref_name: 'its just a name',id: i+1,user_id: 1, ref_value: Faker::Commerce.price,ref_type: (i%2)+1,ref_status: 1,ref_month: 3,ref_year: Date.today.year,expense_category_id: 1+i)
#end

(1..5).each do |i|
  # Bill.create(expenseid: Faker::Commerce.department, day_month: Faker::Number.number(2), month: Faker::Number.between(from =1, to =12), year: Faker::Number.between(from = 1901, to=2016), user_id: 1)
  Bill.create(bill_status: 1,expire_month:10,expire_year:Date.today.year,day_month: rand(1..25), month: 3, year: Date.today.year, user_id: 1,amount: rand(50..100),expense_category_id: 1,bill_name: 'rent')

end
(6..10).each do |i|
  # Bill.create(expenseid: Faker::Commerce.department, day_month: Faker::Number.number(2), month: Faker::Number.between(from =1, to =12), year: Faker::Number.between(from = 1901, to=2016), user_id: 1)
  Bill.create(bill_status: 1,expire_month:10,expire_year:Date.today.year,day_month: rand(1..25), month: 4, year: Date.today.year, user_id: 1,amount: rand(50..100),expense_category_id: 1,bill_name: 'rent')

end
(11..15).each do |i|
  # Bill.create(expenseid: Faker::Commerce.department, day_month: Faker::Number.number(2), month: Faker::Number.between(from =1, to =12), year: Faker::Number.between(from = 1901, to=2016), user_id: 1)
  Bill.create(bill_status: 1,expire_month:10,expire_year:Date.today.year,day_month: rand(1..25), month: 5, year: Date.today.year, user_id: 1,amount: rand(50..100),expense_category_id: 1,bill_name: 'rent')

end



Income.create(user_id: 1, income: "Stipend", incometype: "salary", value: 2000, frequency: "biweekly", day_rec: Faker::Number.number(2), month: Date.today.month, year: Date.today.year)
Income.create(user_id: 1, income: "Family", incometype: "salary", value: 500, frequency: "biweekly", day_rec: Faker::Number.number(2), month: Date.today.month, year: Date.today.year)
Income.create(user_id: 1, income: "TA", incometype: "salary", value: 400, frequency: "biweekly", day_rec: Faker::Number.number(2), month: Date.today.month, year: Date.today.year)
