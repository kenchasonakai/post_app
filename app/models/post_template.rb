class PostTemplate < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  belongs_to :user

  def self.embed_contents(**kwargs)
    keys = %w[user_name]
    target_colmn = :content
    all.each do |record|
      content = record.send(target_colmn)
      content.scan(/\#\{(.+?)\}/).each do |key|
        if keys.include?(key[0]) && kwargs.key?(key[0].to_sym)
          content.gsub!(/\#\{#{key[0]}\}/, kwargs[key[0].to_sym].to_s)
        end
      end
      record.assign_attributes(target_colmn => content)
    end
  end
end
