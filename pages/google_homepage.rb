class GoogleHomepage < SitePrism::Page

  set_url '/'

  # ELEMENTS
  element :google_logo,                '#hplogo'
  element :search_field,               'input[name="q"]'
  element :search_button,              'input[name="btnK"]'

end