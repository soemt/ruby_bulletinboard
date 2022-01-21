require "application_system_test_case"

class ForeignKeysTest < ApplicationSystemTestCase
  setup do
    @foreign_key = foreign_keys(:one)
  end

  test "visiting the index" do
    visit foreign_keys_url
    assert_selector "h1", text: "Foreign keys"
  end

  test "should create foreign key" do
    visit foreign_keys_url
    click_on "New foreign key"

    click_on "Create Foreign key"

    assert_text "Foreign key was successfully created"
    click_on "Back"
  end

  test "should update Foreign key" do
    visit foreign_key_url(@foreign_key)
    click_on "Edit this foreign key", match: :first

    click_on "Update Foreign key"

    assert_text "Foreign key was successfully updated"
    click_on "Back"
  end

  test "should destroy Foreign key" do
    visit foreign_key_url(@foreign_key)
    click_on "Destroy this foreign key", match: :first

    assert_text "Foreign key was successfully destroyed"
  end
end
