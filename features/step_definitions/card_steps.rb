Given /^no cards$/ do
  Card.destroy_all
end

When /^I add a card with$/ do |table|
  visit new_card_path
  card_data = table.hashes.first
  fill_in :card_title, :with => card_data[:title]
  fill_in :card_description, :with => card_data[:description]
  fill_in :card_points, :with => card_data[:points]
  click_button 'Create'
end

Then /^I should see the "([^"]*)" card$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should have_selector("div", :id => "card_#{card.id}") do |card_div|
    card_div.should contain(card.title)
    card_div.should contain(card.description)
    card_div.should contain(card.points.to_s)
  end
end

Given /^a "([^\"]*)" card$/ do |title|
  Card.create!(
    :title => title,
    :description => "description for #{title}",
    :points => title.length
  )
end

Given /^a "([^\"]*)" card in iteration starting "([^\"]*)"$/ do |title, iteration_start_date|
  Card.create!(
    :title => title,
    :description => "description for #{title}",
    :points => title.length,
    :iteration => Iteration.find_by_start_date(Date.parse(iteration_start_date))
  )
end

When /^I add a "([^\"]*)" card$/ do |title|
  visit new_card_path
  fill_in :card_title, :with => title
  fill_in :card_description, :with => "description for #{title}"
  fill_in :card_points, :with => title.length
  click_button 'Create'
end

Then /^I should not see the "([^\"]*)" card$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should_not have_selector("div", :id => "card_#{card.id}")
end
