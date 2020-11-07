require "application_system_test_case"

class TextosTest < ApplicationSystemTestCase
  setup do
    @texto = textos(:one)
  end

  test "visiting the index" do
    visit textos_url
    assert_selector "h1", text: "Textos"
  end

  test "creating a Texto" do
    visit textos_url
    click_on "New Texto"

    fill_in "Calificacion", with: @texto.calificacion
    fill_in "Publicacion", with: @texto.publicacion_id
    fill_in "Texto", with: @texto.texto
    click_on "Create Texto"

    assert_text "Texto was successfully created"
    click_on "Back"
  end

  test "updating a Texto" do
    visit textos_url
    click_on "Edit", match: :first

    fill_in "Calificacion", with: @texto.calificacion
    fill_in "Publicacion", with: @texto.publicacion_id
    fill_in "Texto", with: @texto.texto
    click_on "Update Texto"

    assert_text "Texto was successfully updated"
    click_on "Back"
  end

  test "destroying a Texto" do
    visit textos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Texto was successfully destroyed"
  end
end
