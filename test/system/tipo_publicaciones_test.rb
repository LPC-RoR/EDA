require "application_system_test_case"

class TipoPublicacionesTest < ApplicationSystemTestCase
  setup do
    @tipo_publicacion = tipo_publicaciones(:one)
  end

  test "visiting the index" do
    visit tipo_publicaciones_url
    assert_selector "h1", text: "Tipo Publicaciones"
  end

  test "creating a Tipo publicacion" do
    visit tipo_publicaciones_url
    click_on "New Tipo Publicacion"

    fill_in "Ejemplo", with: @tipo_publicacion.ejemplo
    fill_in "Redireccion", with: @tipo_publicacion.redireccion
    fill_in "Tipo publicacion", with: @tipo_publicacion.tipo_publicacion
    click_on "Create Tipo publicacion"

    assert_text "Tipo publicacion was successfully created"
    click_on "Back"
  end

  test "updating a Tipo publicacion" do
    visit tipo_publicaciones_url
    click_on "Edit", match: :first

    fill_in "Ejemplo", with: @tipo_publicacion.ejemplo
    fill_in "Redireccion", with: @tipo_publicacion.redireccion
    fill_in "Tipo publicacion", with: @tipo_publicacion.tipo_publicacion
    click_on "Update Tipo publicacion"

    assert_text "Tipo publicacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Tipo publicacion" do
    visit tipo_publicaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tipo publicacion was successfully destroyed"
  end
end
