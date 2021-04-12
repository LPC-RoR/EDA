require "application_system_test_case"

class DirectoriosTest < ApplicationSystemTestCase
  setup do
    @directorio = directorios(:one)
  end

  test "visiting the index" do
    visit directorios_url
    assert_selector "h1", text: "Directorios"
  end

  test "creating a Directorio" do
    visit directorios_url
    click_on "New Directorio"

    fill_in "Directorio", with: @directorio.directorio
    fill_in "Proyecto", with: @directorio.proyecto_id
    click_on "Create Directorio"

    assert_text "Directorio was successfully created"
    click_on "Back"
  end

  test "updating a Directorio" do
    visit directorios_url
    click_on "Edit", match: :first

    fill_in "Directorio", with: @directorio.directorio
    fill_in "Proyecto", with: @directorio.proyecto_id
    click_on "Update Directorio"

    assert_text "Directorio was successfully updated"
    click_on "Back"
  end

  test "destroying a Directorio" do
    visit directorios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Directorio was successfully destroyed"
  end
end
