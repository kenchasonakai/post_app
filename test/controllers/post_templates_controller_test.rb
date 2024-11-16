require 'test_helper'

class PostTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_template = post_templates(:one_post_template)
    @user = users(:one_user)
    login_as(@user, scope: :user)
  end

  test "should get new" do
    get new_post_template_url
    assert_response :success
    assert_not_nil assigns(:post_template)
  end

  test "should create post_template" do
    assert_difference('PostTemplate.count') do
      post post_templates_url, params: { post_template: { title: 'Sample Title', content: 'Sample Content' } }
    end

    assert_redirected_to new_post_url
    assert_equal 'テンプレートを作成しました', flash[:notice]
  end

  test "should not create post_template with invalid params" do
    post post_templates_url, params: { post_template: { title: '', content: '' } }
    assert_response :unprocessable_entity
    assert_not_nil flash.now[:alert]
  end

  test "should get index" do
    get post_templates_url
    assert_response :success
    assert_not_nil assigns(:post_templates)
  end

  test "should get index as json" do
    get post_templates_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_empty json_response
  end
end