Given(/^@flynn isn't in the system$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I authenticate on "(.*?)" with "(.*?)" account$/) do |service, user|
  set_omniauth service
  visit "/auth/#{service.downcase}"
end

Then(/^I should see "(.*?)"$/) do |msg|
  pending # express the regexp above with the code you wish you had
end

Given(/^@flynn is in the system$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^this "(.*?)" is not linked with "(.*?)" account$/) do |service, user|
  pending # express the regexp above with the code you wish you had
end

Then(/^this "(.*?)" is already linked with "(.*?)" account$/) do |service, user|
  pending # express the regexp above with the code you wish you had
end
