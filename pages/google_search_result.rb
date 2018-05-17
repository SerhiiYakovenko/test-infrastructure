class GoogleSearchResult < SitePrism::Page

  # ELEMENTS
  element :google_logo,                '#logo'
  element :search_field,               'input[name="q"]'
  element :search_button,              'button[name="btnG"]'
  element :results_count,              '#resultStats'
  element :results_list,               '#search'

end