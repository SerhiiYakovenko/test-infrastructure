class GoogleHomepage < SitePrism::Page

  set_url '/'

  # ELEMENTS
  element :google_logo,                '#hplogo'
  element :search_field,               'input[name="q"]'
  element :search_button,    :xpath, '//div/span[1]/span/input'

end