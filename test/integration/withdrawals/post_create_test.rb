require 'test_helper'

class PostCreateTest < ActionDispatch::IntegrationTest
  test "post create withdrawal" do
    # Given
    notes_params = { "bankNotes": { "1": 10, "5": 7, "10": 9, "50": 3 } }
    post api_v1_deposits_path, params: notes_params
    params = { "amount": 85 }
    expected_response = {"50"=>1, "10"=>3, "5"=>1}

    # When
    post api_v1_withdrawals_path, params: params

    #Then
    assert_response :ok
    assert_equal expected_response, response.parsed_body
  end

  test "fails when no possitive amount" do
    # Given
    params = { "amount": -85 }

    # When
    post api_v1_withdrawals_path, params: params

    # Then
    assert_response :precondition_failed
  end

  test "fails when not enough money" do
    # Given
    notes_params = { "bankNotes": { "1": 10, "5": 7 } }
    post api_v1_deposits_path, params: notes_params
    params = { "amount": 85 }
    expected_response = {"50"=>1, "10"=>3, "5"=>1}

    # When
    post api_v1_withdrawals_path, params: params
    # Then
    assert_response :precondition_failed
  end

  test "fails when missing body on request" do
    # When
    post api_v1_withdrawals_path
    # Then
    assert_response :precondition_failed
  end
end