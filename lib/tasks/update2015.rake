namespace :update2015 do

    unless Teacher.where(_id: 'desandrea').exists?
      Teacher.create! current: true, last_name: 'DeSandre', first_name: 'Alyssa', \
        title: 'Ms', password: 'tsro2i5', login: 'desandrea', email: 'desandrea@weston.org'
    end

    unless Teacher.where(_id: 'gettysa').exists?
      Teacher.create! current: true, last_name: 'Gettys', first_name: 'Andi', \
        title: 'Ms', password: 'VT7tpm', login: 'gettysa', email: 'gettysa@weston.org'
    end

  task :sections => :environment do
    require Rails.root.join('import/convert')
    Section.where(year: 2015).delete_all
    arr = Convert.import_xml_file "sections2015.xml"
    Convert.from_hashes Section, arr, false
  end
end
