module ImportFile
  extend ActiveSupport::Concern

  module ClassMethods
    def import_file(file_path, options = {})
      CSV.foreach(file_path, headers: true) do |row|
        record = find_by_id(row.field('id')) || new
        record.attributes = row.to_hash.except('id')
        record.save!
      end
    end
  end
end