require "application_system_test_case"

class AsociacionesTest < ApplicationSystemTestCase
  setup do
    @asociacion = asociaciones(:one)
  end

  test "visiting the index" do
    visit asociaciones_url
    assert_selector "h1", text: "Asociaciones"
  end

  test "creating a Asociacion" do
    visit asociaciones_url
    click_on "New Asociacion"

    fill_in "Proyecto", with: @asociacion.proyecto_id
    fill_in "Publicacion", with: @asociacion.publicacion_id
    click_on "Create Asociacion"

    assert_text "Asociacion was successfully created"
    click_on "Back"
  end

  test "updating a Asociacion" do
    visit asociaciones_url
    click_on "Edit", match: :first

    fill_in "Proyecto", with: @asociacion.proyecto_id
    fill_in "Publicacion", with: @asociacion.publicacion_id
    click_on "Update Asociacion"

    assert_text "Asociacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Asociacion" do
    visit asociaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asociacion was successfully destroyed"
  end
end
