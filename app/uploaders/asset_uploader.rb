# encoding: utf-8
class AssetUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  if Rails.env.test? or Rails.env.cucumber?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  # elsif Rails.env.development?
  #   CarrierWave.configure do |config|
  #     config.storage = :file
  #     config.enable_processing = true
  #   end
  else
    CarrierWave.configure do |config|
      config.storage = :fog
      config.enable_processing = true
    end
  end

end
