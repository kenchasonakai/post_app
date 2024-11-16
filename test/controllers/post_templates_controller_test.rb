require "test_helper"
class PostTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_template = post_templates(:one_post_template)
    @user = users(:one_user)
    login_as(@user, scope: :user)
  end

  test "should get index" do
    get post_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_post_template_url
    assert_response :success
  end

  test "should create post_template" do
    assert_difference("PostTemplate.count") do
      post post_templates_url, params: { post_template: { title: "New Title", content: "New Content" } }
    end
    assert_redirected_to post_templates_path
  end

  test "should show post_template" do
    get post_template_url(@post_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_template_url(@post_template)
    assert_response :success
  end

  test "should update post_template" do
    patch post_template_url(@post_template), params: { post_template: { title: "Updated Title", content: "Updated Content" } }
    assert_redirected_to post_template_path(@post_template)
  end

  test "should destroy post_template" do
    assert_difference("PostTemplate.count", -1) do
      delete post_template_url(@post_template)
    end
    assert_redirected_to post_templates_path
  end
end
