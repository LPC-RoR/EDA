require "application_system_test_case"

class OpcionesTest < ApplicationSystemTestCase
  setup do
    @opcion = opciones(:one)
  end

  test "visiting the index" do
    visit opciones_url
    assert_selector "h1", text: "Opciones"
  end

  test "creating a Opcion" do
    visit opciones_url
    click_on "New Opcion"

    fill_in "Caracteristica", with: @opcion.caracteristica_id
    fill_in "Opcion", with: @opcion.opcion
    click_on "Create Opcion"

    assert_text "Opcion was successfully created"
    click_on "Back"
  end

  test "updating a Opcion" do
    visit opciones_url
    click_on "Edit", match: :first

    fill_in "Caracteristica", with: @opcion.caracteristica_id
    fill_in "Opcion", with: @opcion.opcion
    click_on "Update Opcion"

    assert_text "Opcion was successfully updated"
    click_on "Back"
  end

  test "destroying a Opcion" do
    visit opciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Opcion was successfully destroyed"
  end
end
