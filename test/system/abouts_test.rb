require "application_system_test_case"

class AboutsTest < ApplicationSystemTestCase
  setup do
    @about = abouts(:one)
  end

  test "visiting the index" do
    visit abouts_url
    assert_selector "h1", text: "Abouts"
  end

  test "creating a About" do
    visit abouts_url
    click_on "New About"

    fill_in "Company name", with: @about.company_name
    fill_in "Description", with: @about.description
    fill_in "Sub title", with: @about.sub_title
    fill_in "Title", with: @about.title
    click_on "Create About"

    assert_text "About was successfully created"
    click_on "Back"
  end

  test "updating a About" do
    visit abouts_url
    click_on "Edit", match: :first

    fill_in "Company name", with: @about.company_name
    fill_in "Description", with: @about.description
    fill_in "Sub title", with: @about.sub_title
    fill_in "Title", with: @about.title
    click_on "Update About"

    assert_text "About was successfully updated"
    click_on "Back"
  end

  test "destroying a About" do
    visit abouts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "About was successfully destroyed"
  end
end
