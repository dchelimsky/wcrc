Given /^no cards$/ do
  Card.destroy_all
end


def create_card(title, iteration = nil)
  Card.create!(
    :title => title,
    :description => "description for #{title}",
    :points => title.length,
    :iteration => iteration
  )
end

Given /^a "([^\"]*)" card$/ do |title|
  create_card title
end

Given /^a "([^\"]*)" card in the iteration starting "([^\"]*)"$/ do |title, start_date|
  create_card title, 
      Iteration.find_or_create_by_start_date_and_number_of_days(
                                          start_date.as_date, 
                                          7)
end

When /^I add a card with$/ do |table|
  visit new_card_path
  card_data = table.hashes.first
  fill_in :card_title, :with => card_data[:title]
  fill_in :card_description, :with => card_data[:description]
  fill_in :card_points, :with => card_data[:points]
  click_button 'Create'
end

When /^I add a "([^\"]*)" card$/ do |title|
  visit new_card_path
  fill_in :card_title, :with => title
  fill_in :card_description, :with => "description for #{title}"
  fill_in :card_points, :with => title.length
  click_button 'Create'
end

When /^I assign the "([^\"]*)" card to the iteration starting "([^\"]*)"$/ do |card_title, start_date|
  iteration = Iteration.find_by_start_date(start_date.as_date)
  card = Card.find_by_title(card_title)
  within("#card_#{card.id}") do |scope|
    scope.select "Iteration: #{start_date}", :from => "card[iteration_id]"
    scope.click_button "Move to:"
  end
end

Then /^I should not see the "([^\"]*)" card$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should_not have_selector("div", :id => "card_#{card.id}")
end

Then /^I should see the "([^"]*)" card$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should have_selector("div", :id => "card_#{card.id}") do |card_div|
    card_div.should contain(card.title)
    card_div.should contain(card.description)
    card_div.should contain(card.points.to_s)
  end
end

