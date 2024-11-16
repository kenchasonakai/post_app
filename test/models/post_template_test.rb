require "test_helper"
class PostTemplateTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", nickname: "testuser")
  end

  test "should not save post template without title" do
    post_template = @user.post_templates.build
    assert_not post_template.save, "Saved the post template without a title"
  end

  test "should not save post template with duplicate title" do
    post_template1 = @user.post_templates.create(title: "Unique Title", content: "Sample content")
    post_template2 = @user.post_templates.build(title: "Unique Title", content: "Another content")
    assert_not post_template2.save, "Saved the post template with a duplicate title"
  end

  test "should embed contents correctly" do
    user_name = "John Doe"
    post_template = @user.post_templates.create(title: "Test Title", content: 'Hello, #{user_name}')
    post_template.reload
    assert_equal "Hello, John Doe", PostTemplate.embed_contents(user_name: user_name).find { |record| record.id == post_template.id }.content
  end
end
