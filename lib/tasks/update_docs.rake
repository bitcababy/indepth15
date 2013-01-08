namespace :docs do
  namespace :update do
    task :state => :environment do
      Document.each do |doc|
        doc.state = :unlocked if doc[:state].nil?
        doc.save
      end
    end
  end

 namespace :delete do
    task :empty => :environment do
      Document.each do |doc|
        doc.state = :unlocked
        if doc.kind_of?(TextDocument )&& doc[:owner_id].nil? && doc.title.empty? && doc.content.empty?
          doc.delete
        end
      end
    end
    task :old_props => :environment do
      Document.each do |doc|
        %W(ma mi).each do |attr|
          doc.remove_attribute(attr)
        end
        doc.save
      end
    end
  end
        
end
