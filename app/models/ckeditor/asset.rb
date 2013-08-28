class Ckeditor::Asset
  include Ckeditor::Orm::Mongoid::AssetBase

  delegate :url, :current_path, :size, :content_type, :filename, :to => :data
  
  validates_presence_of :data
  belongs_to :orig, class_name: 'TextDocument', autosave: true
end
