require "application_system_test_case"

class HomepagessesTest < ApplicationSystemTestCase
  setup do
    @homepagess = homepagesses(:one)
  end

  test "visiting the index" do
    visit homepagesses_url
    assert_selector "h1", text: "Homepagesses"
  end

  test "creating a Homepagess" do
    visit homepagesses_url
    click_on "New Homepagess"

    fill_in "Brand name", with: @homepagess.brand_name
    fill_in "Description", with: @homepagess.description
    fill_in "Title", with: @homepagess.title
    click_on "Create Homepagess"

    assert_text "Homepagess was successfully created"
    click_on "Back"
  end

  test "updating a Homepagess" do
    visit homepagesses_url
    click_on "Edit", match: :first

    fill_in "Brand name", with: @homepagess.brand_name
    fill_in "Description", with: @homepagess.description
    fill_in "Title", with: @homepagess.title
    click_on "Update Homepagess"

    assert_text "Homepagess was successfully updated"
    click_on "Back"
  end

  test "destroying a Homepagess" do
    visit homepagesses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Homepagess was successfully destroyed"
  end
end
