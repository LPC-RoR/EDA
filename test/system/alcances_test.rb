require "application_system_test_case"

class AlcancesTest < ApplicationSystemTestCase
  setup do
    @alcance = alcances(:one)
  end

  test "visiting the index" do
    visit alcances_url
    assert_selector "h1", text: "Alcances"
  end

  test "creating a Alcance" do
    visit alcances_url
    click_on "New Alcance"

    fill_in "Carpeta", with: @alcance.carpeta_id
    fill_in "Reporte", with: @alcance.reporte_id
    click_on "Create Alcance"

    assert_text "Alcance was successfully created"
    click_on "Back"
  end

  test "updating a Alcance" do
    visit alcances_url
    click_on "Edit", match: :first

    fill_in "Carpeta", with: @alcance.carpeta_id
    fill_in "Reporte", with: @alcance.reporte_id
    click_on "Update Alcance"

    assert_text "Alcance was successfully updated"
    click_on "Back"
  end

  test "destroying a Alcance" do
    visit alcances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Alcance was successfully destroyed"
  end
end
