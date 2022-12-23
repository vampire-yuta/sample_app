require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    asset_equal full_title,         "Ruby on Rails Tutorial Sample App"
    asset_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
  end
end
