class DeptSettings < Settingslogic
  source "#{Rails.root}/config/department.yml"
  namespace Rails.env
end
