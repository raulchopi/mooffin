Given(/^I visit the home page$/) do
  visit home_path
end

When(/^I try to sign up with "(.*?)"$/) do |provider|
  visit "/auth/#{provider.downcase}"
end

When(/^I authenticate on "(.*?)" with "(.*?)" account$/) do |provider, user|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should redirect to my new profile page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |msg|
  pending # express the regexp above with the code you wish you had
end

When(/^I try to sign in with "(.*?)"$/) do |provider|
  pending # express the regexp above with the code you wish you had
end

When(/^this "(.*?)" is not linked with "(.*?)" account$/) do |provider, user|
  pending # express the regexp above with the code you wish you had
end

When(/^this "(.*?)" is already linked with "(.*?)" account$/) do |provider, user|
  pending # express the regexp above with the code you wish you had
end
