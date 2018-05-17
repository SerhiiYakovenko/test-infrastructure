class GoogleHomepage < SitePrism::Page

  set_url '/'

  # ELEMENTS
  element :google_logo,                '#hplogo'
  element :search_field,               'input[name="q"]'
  element :search_button,              'span input[value="Google Search"]'

end