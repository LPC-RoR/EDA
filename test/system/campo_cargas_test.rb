require "application_system_test_case"

class CampoCargasTest < ApplicationSystemTestCase
  setup do
    @campo_carga = campo_cargas(:one)
  end

  test "visiting the index" do
    visit campo_cargas_url
    assert_selector "h1", text: "Campo Cargas"
  end

  test "creating a Campo carga" do
    visit campo_cargas_url
    click_on "New Campo Carga"

    fill_in "Campo carga", with: @campo_carga.campo_carga
    fill_in "Campo tabla", with: @campo_carga.campo_tabla
    fill_in "Formato carga", with: @campo_carga.formato_carga_id
    click_on "Create Campo carga"

    assert_text "Campo carga was successfully created"
    click_on "Back"
  end

  test "updating a Campo carga" do
    visit campo_cargas_url
    click_on "Edit", match: :first

    fill_in "Campo carga", with: @campo_carga.campo_carga
    fill_in "Campo tabla", with: @campo_carga.campo_tabla
    fill_in "Formato carga", with: @campo_carga.formato_carga_id
    click_on "Update Campo carga"

    assert_text "Campo carga was successfully updated"
    click_on "Back"
  end

  test "destroying a Campo carga" do
    visit campo_cargas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Campo carga was successfully destroyed"
  end
end
