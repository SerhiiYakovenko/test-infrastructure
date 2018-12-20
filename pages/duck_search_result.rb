class DuckSearchResult < SitePrism::Page

  # ELEMENTS
  element :duck_logo,                  'span[class*="js-logo-ddg"]'
  element :search_field,               'input[name="q"]'
  element :search_button,              'button[name="btnG"]'
  element :results_list,               '#links'

end