Given /^no iterations$/ do
  Iteration.destroy_all
end

Given /^a (\d*) day iteration beginning "([^\"]*)"$/ do |number_of_days, start_date|
  Iteration.create!(:start_date => start_date, :number_of_days => number_of_days)
end

When /^I add an iteration with$/ do |table|
  iteration_data = table.hashes.first
  visit new_iteration_path
  fill_in :iteration_start_date, :with => iteration_data[:start_date]
  fill_in :iteration_number_of_days, :with => iteration_data[:number_of_days]
  click_button 'Create'
end

Then /^I should see "([^\"]*)" starting on "([^\"]*)"$/ do
    |iteration_title, start_date|
  iteration = Iteration.find_by_start_date(start_date.as_date)
  response.should have_selector("div#iteration_#{iteration.id}") do |div|
    div.should contain(iteration_title)
    div.should contain(start_date)
  end
end

Then /^I should see the "([^\"]*)" card in the iteration starting "([^\"]*)"$/ do |card_title, start_date|
  iteration = Iteration.find_by_start_date(start_date.as_date)
  within("#iteration_#{iteration.id}") do |scope|
    scope.should contain(card_title)
  end
end

