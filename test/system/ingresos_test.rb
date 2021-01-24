require "application_system_test_case"

class IngresosTest < ApplicationSystemTestCase
  setup do
    @ingreso = ingresos(:one)
  end

  test "visiting the index" do
    visit ingresos_url
    assert_selector "h1", text: "Ingresos"
  end

  test "creating a Ingreso" do
    visit ingresos_url
    click_on "New Ingreso"

    click_on "Create Ingreso"

    assert_text "Ingreso was successfully created"
    click_on "Back"
  end

  test "updating a Ingreso" do
    visit ingresos_url
    click_on "Edit", match: :first

    click_on "Update Ingreso"

    assert_text "Ingreso was successfully updated"
    click_on "Back"
  end

  test "destroying a Ingreso" do
    visit ingresos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ingreso was successfully destroyed"
  end
end
