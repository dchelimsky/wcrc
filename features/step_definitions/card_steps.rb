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

Given /^a card with$/ do |table|
  card_data = table.hashes.first.dup
  card_data[:iteration] = Iteration.find_by_start_date(card_data[:iteration].as_date)
  Card.create!(card_data)
end

Given /^a "([^\"]*)" card in the iteration starting "([^\"]*)"$/ do |title, start_date|
  create_card title, 
      Iteration.find_or_create_by_start_date_and_number_of_days(
                                          start_date.as_date, 
                                          7)
end

Given /^a "([^\"]*)" card in the backlog$/ do |title|
  create_card title
end

Given /^the "([^\"]*)" card has higher priority than the "([^\"]*)" card$/ do |first_title, second_title|
  first_card = Card.find_by_title(first_title)
  second_card = Card.find_by_title(second_title)
  first_card.update_attributes!(:priority => 1) unless first_card.priority
  second_card.update_attributes!(:priority => first_card.priority + 1)
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

When /^I move the "([^\"]*)" card to the iteration starting "([^\"]*)"$/ do |card_title, start_date|
  visit iterations_path
  iteration = Iteration.find_by_start_date(start_date.as_date)
  card = Card.find_by_title(card_title)
  within("#card_#{card.id}") do |scope|
    scope.select "Iteration: #{start_date}", :from => "card[iteration_id]"
    scope.click_button "Move to:"
  end
end

When /^I move the "([^\"]*)" card to the backlog$/ do |card_title|
  card = Card.find_by_title(card_title)
  within("#card_#{card.id}") do |scope|
    scope.select "Backlog", :from => "card[iteration_id]"
    scope.click_button "Move to:"
  end
end

When /^I increase the priority of the "([^\"]*)" card$/ do |title|
  visit iterations_path
  card = Card.find_by_title(title)
  within("#card_#{card.id}") do |scope|
    scope.click_button "Move up"
  end
end

Then /^I should see detailed information for the "([^\"]*)" card$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should contain(card.title)
  response.should contain(card.description)
  response.should contain(card.points.to_s)
end

Then /^I should see the "([^\"]*)" card in the iteration starting "([^\"]*)"$/ do |card_title, start_date|
  iteration = Iteration.find_by_start_date(start_date.as_date)
  within("#iteration_#{iteration.id}") do |scope|
    scope.should contain(card_title)
  end
end

Then /^I should not see the "([^\"]*)" card in the iteration starting "([^\"]*)"$/ do |card_title, start_date|
  iteration = Iteration.find_by_start_date(start_date.as_date)
  within("#iteration_#{iteration.id}") do |scope|
    scope.should_not contain(card_title)
  end
end

Then /^I should see the "([^\"]*)" card in the backlog$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should have_xpath("//div[@id = 'backlog']//div[@id = 'card_#{card.id}']")
end

Then /^I should not see the "([^\"]*)" card in the backlog$/ do |card_title|
  card = Card.find_by_title(card_title)
  response.should_not have_xpath("//div[@id = 'backlog']//div[@id = 'card_#{card.id}']")
end

Then /^I should not see any cards in the backlog$/ do
  within("#backlog") do |scope|
    scope.should_not have_xpath(".//div[starts-with(@id, 'card_')]")
  end
end

Then /^the "([^\"]*)" card should be lower priority than the "([^\"]*)" card$/ do |first_title, second_title|
  lower_card = Card.find_by_title(first_title)
  higher_card = Card.find_by_title(second_title)
  within('#iterations') do |iterations|
    within('.card_list') do |card_list|
      card_list.should have_xpath(".//li[position()=1]/div[@id='card_#{higher_card.id}']")
      card_list.should have_xpath(".//li[position()=2]/div[@id='card_#{lower_card.id}']")
    end
  end
end

Then /^the "([^\"]*)" card should be higher priority than the "([^\"]*)" card$/ do |first_title, second_title|
  lower_card = Card.find_by_title(first_title)
  higher_card = Card.find_by_title(second_title)
  within('#iterations') do |iterations|
    within('.card_list') do |card_list|
      card_list.should have_xpath(".//li[position()=1]/div[@id='card_#{higher_card.id}']")
      card_list.should have_xpath(".//li[position()=2]/div[@id='card_#{lower_card.id}']")
    end
  end
end
