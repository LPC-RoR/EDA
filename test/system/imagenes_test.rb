require "application_system_test_case"

class ImagenesTest < ApplicationSystemTestCase
  setup do
    @imagen = imagenes(:one)
  end

  test "visiting the index" do
    visit imagenes_url
    assert_selector "h1", text: "Imagenes"
  end

  test "creating a Imagen" do
    visit imagenes_url
    click_on "New Imagen"

    fill_in "Imagen", with: @imagen.imagen
    fill_in "Linea", with: @imagen.linea_id
    fill_in "Nota", with: @imagen.nota
    fill_in "Orden", with: @imagen.orden
    click_on "Create Imagen"

    assert_text "Imagen was successfully created"
    click_on "Back"
  end

  test "updating a Imagen" do
    visit imagenes_url
    click_on "Edit", match: :first

    fill_in "Imagen", with: @imagen.imagen
    fill_in "Linea", with: @imagen.linea_id
    fill_in "Nota", with: @imagen.nota
    fill_in "Orden", with: @imagen.orden
    click_on "Update Imagen"

    assert_text "Imagen was successfully updated"
    click_on "Back"
  end

  test "destroying a Imagen" do
    visit imagenes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Imagen was successfully destroyed"
  end
end
