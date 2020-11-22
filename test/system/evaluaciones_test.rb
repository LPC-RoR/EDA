require "application_system_test_case"

class EvaluacionesTest < ApplicationSystemTestCase
  setup do
    @evaluacion = evaluaciones(:one)
  end

  test "visiting the index" do
    visit evaluaciones_url
    assert_selector "h1", text: "Evaluaciones"
  end

  test "creating a Evaluacion" do
    visit evaluaciones_url
    click_on "New Evaluacion"

    fill_in "Conclusion", with: @evaluacion.conclusion
    fill_in "Metodologia", with: @evaluacion.metodologia
    fill_in "Objetivo", with: @evaluacion.objetivo
    fill_in "Publicacion", with: @evaluacion.publicacion_id
    fill_in "Resultado", with: @evaluacion.resultado
    click_on "Create Evaluacion"

    assert_text "Evaluacion was successfully created"
    click_on "Back"
  end

  test "updating a Evaluacion" do
    visit evaluaciones_url
    click_on "Edit", match: :first

    fill_in "Conclusion", with: @evaluacion.conclusion
    fill_in "Metodologia", with: @evaluacion.metodologia
    fill_in "Objetivo", with: @evaluacion.objetivo
    fill_in "Publicacion", with: @evaluacion.publicacion_id
    fill_in "Resultado", with: @evaluacion.resultado
    click_on "Update Evaluacion"

    assert_text "Evaluacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Evaluacion" do
    visit evaluaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Evaluacion was successfully destroyed"
  end
end
