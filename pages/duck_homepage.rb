class DuckHomepage < SitePrism::Page

  set_url '/'

  # ELEMENTS
  element :duck_logo,                  '#logo_homepage_link'
  element :search_field,               '#search_form_input_homepage'
  element :search_button,              '#search_button_homepage'

end