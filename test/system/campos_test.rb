require "application_system_test_case"

class CamposTest < ApplicationSystemTestCase
  setup do
    @campo = campos(:one)
  end

  test "visiting the index" do
    visit campos_url
    assert_selector "h1", text: "Campos"
  end

  test "creating a Campo" do
    visit campos_url
    click_on "New Campo"

    fill_in "Campo", with: @campo.campo
    check "Cursiva" if @campo.cursiva
    check "Negrita" if @campo.negrita
    fill_in "Orden", with: @campo.orden
    click_on "Create Campo"

    assert_text "Campo was successfully created"
    click_on "Back"
  end

  test "updating a Campo" do
    visit campos_url
    click_on "Edit", match: :first

    fill_in "Campo", with: @campo.campo
    check "Cursiva" if @campo.cursiva
    check "Negrita" if @campo.negrita
    fill_in "Orden", with: @campo.orden
    click_on "Update Campo"

    assert_text "Campo was successfully updated"
    click_on "Back"
  end

  test "destroying a Campo" do
    visit campos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Campo was successfully destroyed"
  end
end
