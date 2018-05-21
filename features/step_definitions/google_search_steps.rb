Given('I visit Google homepage') do
  visit_homepage
end

When('I search for some data') do
  @used_word = random_word
  @google_homepage.search_field.set @used_word
  @google_homepage.search_button.click
end

Then('I see results') do
  @google_search_result = GoogleSearchResult.new
  expect(@google_search_result.google_logo).to be_visible
  expect(@google_search_result.results_count).to be_visible
  expect(@google_search_result.results_list.text).to include(@used_word)
end