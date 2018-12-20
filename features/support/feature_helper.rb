# This module is used to handle repeating actions within Cucumber steps e.g. login or logout

module FeatureHelper
  def visit_homepage
    @duck_homepage = DuckHomepage.new
    @duck_homepage.load
  end

  def random_word
    %W(Batman Superman Hulk Tor Loki Tanos Grut).sample
  end
end

World(FeatureHelper)