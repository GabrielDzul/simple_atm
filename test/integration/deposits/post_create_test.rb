require 'test_helper'

class PostCreateTest < ActionDispatch::IntegrationTest
  test "post deposits" do
    # Given
    params = { "bankNotes": { "1": 10, "5": 7, "10": 9, "50": 3 } }
    expected_response = { "1"=> 10, "2"=> 0, "5"=> 7, "10"=> 9, "25"=> 0, "50"=> 3 }

    # When
    post api_v1_deposits_path, params: params

    #Then
    assert_response :ok
    assert_equal expected_response, response.parsed_body
  end

  test "fails when missing body on request" do
    # When
    post api_v1_deposits_path

    #Then
    assert_response :precondition_failed
  end

  test "fails with incorrect payload" do
    # Given
    params = { "bankNotes": { "1": 10, "5": 7, "10": -9, "50": 3 } }

    # When
    post api_v1_deposits_path, params: params

    # Then
    assert_response :precondition_failed
  end
end