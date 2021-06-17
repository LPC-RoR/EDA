require "application_system_test_case"

class ReportesTest < ApplicationSystemTestCase
  setup do
    @reporte = reportes(:one)
  end

  test "visiting the index" do
    visit reportes_url
    assert_selector "h1", text: "Reportes"
  end

  test "creating a Reporte" do
    visit reportes_url
    click_on "New Reporte"

    fill_in "Proyecto", with: @reporte.proyecto_id
    fill_in "Reporte", with: @reporte.reporte
    click_on "Create Reporte"

    assert_text "Reporte was successfully created"
    click_on "Back"
  end

  test "updating a Reporte" do
    visit reportes_url
    click_on "Edit", match: :first

    fill_in "Proyecto", with: @reporte.proyecto_id
    fill_in "Reporte", with: @reporte.reporte
    click_on "Update Reporte"

    assert_text "Reporte was successfully updated"
    click_on "Back"
  end

  test "destroying a Reporte" do
    visit reportes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reporte was successfully destroyed"
  end
end
