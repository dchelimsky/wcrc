Given /^no cards$/ do
  Card.destroy_all
end

When /^I add a card with$/ do |table|
  card_data = table.hashes.first
  visit new_card_path
  fill_in :card_title, :with => card_data[:title]
  fill_in :card_description, :with => card_data[:description]
  fill_in :card_points, :with => card_data[:points]
  click_button "Create"
end

Then /^I should see the "([^\"]*)" card$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should contain(card.title)
  response.should contain(card.description)
  response.should contain(card.points.to_s)
end
