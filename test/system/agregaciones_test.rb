require "application_system_test_case"

class AgregacionesTest < ApplicationSystemTestCase
  setup do
    @agregacioneses = agregaciones(:one)
  end

  test "visiting the index" do
    visit agregaciones_url
    assert_selector "h1", text: "Agregaciones"
  end

  test "creating a Agregacion" do
    visit agregaciones_url
    click_on "New Agregacion"

    fill_in "Categoria", with: @agregacioneses.categoria_id
    fill_in "Concepto", with: @agregacioneses.concepto_id
    click_on "Create Agregacion"

    assert_text "Agregacion was successfully created"
    click_on "Back"
  end

  test "updating a Agregacion" do
    visit agregaciones_url
    click_on "Edit", match: :first

    fill_in "Categoria", with: @agregacioneses.categoria_id
    fill_in "Concepto", with: @agregacioneses.concepto_id
    click_on "Update Agregacion"

    assert_text "Agregacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Agregacion" do
    visit agregaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Agregacion was successfully destroyed"
  end
end
