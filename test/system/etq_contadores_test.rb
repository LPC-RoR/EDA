require "application_system_test_case"

class EtqContadoresTest < ApplicationSystemTestCase
  setup do
    @etq_contador = etq_contadores(:one)
  end

  test "visiting the index" do
    visit etq_contadores_url
    assert_selector "h1", text: "Etq Contadores"
  end

  test "creating a Etq contador" do
    visit etq_contadores_url
    click_on "New Etq Contador"

    fill_in "Etiqueta", with: @etq_contador.etiqueta_id
    fill_in "Publicacion", with: @etq_contador.publicacion_id
    click_on "Create Etq contador"

    assert_text "Etq contador was successfully created"
    click_on "Back"
  end

  test "updating a Etq contador" do
    visit etq_contadores_url
    click_on "Edit", match: :first

    fill_in "Etiqueta", with: @etq_contador.etiqueta_id
    fill_in "Publicacion", with: @etq_contador.publicacion_id
    click_on "Update Etq contador"

    assert_text "Etq contador was successfully updated"
    click_on "Back"
  end

  test "destroying a Etq contador" do
    visit etq_contadores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Etq contador was successfully destroyed"
  end
end
