Given('I visit Duck homepage') do
  visit_homepage
end

When('I search for some data') do
  @used_word = random_word
  @duck_homepage.search_field.set @used_word
  @duck_homepage.search_button.click
end

Then('I see results') do
  @duck_search_result = DuckSearchResult.new
  expect(@duck_search_result.duck_logo).to be_visible
  expect(@duck_search_result.results_list.text).to include(@used_word)
end