require "test_helper"

class DonorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donor = donors(:one)
  end

  test "should get index" do
    get donors_url, as: :json
    assert_response :success
  end

  test "should create donor" do
    assert_difference("Donor.count") do
      post donors_url, params: { donor: { email: @donor.email, method: @donor.method, mobile: @donor.mobile, name: @donor.name, status: @donor.status, user_id: @donor.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show donor" do
    get donor_url(@donor), as: :json
    assert_response :success
  end

  test "should update donor" do
    patch donor_url(@donor), params: { donor: { email: @donor.email, method: @donor.method, mobile: @donor.mobile, name: @donor.name, status: @donor.status, user_id: @donor.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy donor" do
    assert_difference("Donor.count", -1) do
      delete donor_url(@donor), as: :json
    end

    assert_response :no_content
  end
end
