require "test_helper"
class PostTemplateTest < ActiveSupport::TestCase
  test "should not save post template without title" do
    post_template = PostTemplate.new
    assert_not post_template.save, "Saved the post template without a title"
  end

  test "should not save post template with duplicate title" do
    post_template1 = PostTemplate.create(title: "Unique Title", content: "Sample content")
    post_template2 = PostTemplate.new(title: "Unique Title", content: "Another content")
    assert_not post_template2.save, "Saved the post template with a duplicate title"
  end

  test "should embed contents correctly" do
    user_name = "John Doe"
    post_template = PostTemplate.create(title: "Test Title", content: 'Hello, #{user_name}')
    post_template.reload
    assert_equal "Hello, John Doe", PostTemplate.embed_contents(user_name: user_name).find { |record| record.id == post_template.id }.content
  end
end
