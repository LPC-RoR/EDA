require "application_system_test_case"

class ColumnasTest < ApplicationSystemTestCase
  setup do
    @columna = columnas(:one)
  end

  test "visiting the index" do
    visit columnas_url
    assert_selector "h1", text: "Columnas"
  end

  test "creating a Columna" do
    visit columnas_url
    click_on "New Columna"

    fill_in "Linea", with: @columna.linea_id
    fill_in "Orden", with: @columna.orden
    click_on "Create Columna"

    assert_text "Columna was successfully created"
    click_on "Back"
  end

  test "updating a Columna" do
    visit columnas_url
    click_on "Edit", match: :first

    fill_in "Linea", with: @columna.linea_id
    fill_in "Orden", with: @columna.orden
    click_on "Update Columna"

    assert_text "Columna was successfully updated"
    click_on "Back"
  end

  test "destroying a Columna" do
    visit columnas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Columna was successfully destroyed"
  end
end
