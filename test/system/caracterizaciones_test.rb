require "application_system_test_case"

class CaracterizacionesTest < ApplicationSystemTestCase
  setup do
    @caracterizacion = caracterizaciones(:one)
  end

  test "visiting the index" do
    visit caracterizaciones_url
    assert_selector "h1", text: "Caracterizaciones"
  end

  test "creating a Caracterizacion" do
    visit caracterizaciones_url
    click_on "New Caracterizacion"

    fill_in "Caracterizacion", with: @caracterizacion.caracterizacion
    fill_in "Proyecto", with: @caracterizacion.proyecto_id
    click_on "Create Caracterizacion"

    assert_text "Caracterizacion was successfully created"
    click_on "Back"
  end

  test "updating a Caracterizacion" do
    visit caracterizaciones_url
    click_on "Edit", match: :first

    fill_in "Caracterizacion", with: @caracterizacion.caracterizacion
    fill_in "Proyecto", with: @caracterizacion.proyecto_id
    click_on "Update Caracterizacion"

    assert_text "Caracterizacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Caracterizacion" do
    visit caracterizaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Caracterizacion was successfully destroyed"
  end
end
