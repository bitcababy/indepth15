namespace :update2014 do
  task :teachers => :environment do

    t = Teacher.find 'abendb'
    t.current = false
    t.save!

    unless Teacher.where(_id: 'hamavida').exists?
      Teacher.create! current: true, last_name: 'Hamavid', first_name: 'Aviva', \
        title: 'Ms', password: 'IssIutng', login: 'hamavida', email: 'hamavida@mail.weston.org'
    end

    if Teacher.where(_id: 'gajewskid').exists?
      t = Teacher.find 'gajewskid'
      t.current = true
      t.save!
    end
  end

  task :sections => :environment do
    require Rails.root.join('import/convert')
    Section.where(year: 2014).delete_all
    arr = Convert.import_xml_file "sections2014.xml"
    Convert.from_hashes Section, arr, false
  end
end
