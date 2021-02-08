require "application_system_test_case"

class VersionesTest < ApplicationSystemTestCase
  setup do
    @version = versiones(:one)
  end

  test "visiting the index" do
    visit versiones_url
    assert_selector "h1", text: "Versiones"
  end

  test "creating a Version" do
    visit versiones_url
    click_on "New Version"

    fill_in "Estado", with: @version.estado
    fill_in "Nota", with: @version.nota
    fill_in "Proyecto", with: @version.proyecto_id
    fill_in "Version", with: @version.version
    click_on "Create Version"

    assert_text "Version was successfully created"
    click_on "Back"
  end

  test "updating a Version" do
    visit versiones_url
    click_on "Edit", match: :first

    fill_in "Estado", with: @version.estado
    fill_in "Nota", with: @version.nota
    fill_in "Proyecto", with: @version.proyecto_id
    fill_in "Version", with: @version.version
    click_on "Update Version"

    assert_text "Version was successfully updated"
    click_on "Back"
  end

  test "destroying a Version" do
    visit versiones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Version was successfully destroyed"
  end
end
