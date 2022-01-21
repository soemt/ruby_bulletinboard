module ExportCsv
  extend ActiveSupport::Concern

  module ClassMethods
    def to_csv
      require 'csv'
      headers = %i[id title description status created_user_id updated_user_id deleted_user_id created_at updated_at]

      CSV.generate(headers: true) do |csv|
        csv << headers

        all.each do |post|
          csv << [post.id, post.title, post.description, post.status, post.created_user_id, post.updated_user_id, post.deleted_user_id, post.created_at, post.updated_at]
        end
      end

    end
  end
  
end