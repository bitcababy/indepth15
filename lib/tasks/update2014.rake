task :update2014 => :environment do
  require Rails.root.join('import/convert')

  t = Teacher.find 'abendb'
  t.current = false
  t.save!

  unless Teacher.where(_id: 'hamavida').exists?
    Teacher.create! current: true, last_name: 'Hamavid', first_name: 'Aviva', \
      title: 'Ms', password: 'IssIutng', login: 'hamavida', email: 'hamavida@mail.weston.org'
  end

  unless Teacher.where(_id: 'gajewskid').exists?
    Teacher.create! current: true, last_name: 'Gajewski', first_name: 'Debbie', \
      title: 'Ms', password: 'witwiw', login: 'gajewskid', email: 'gajewskid@mail.weston.org'
  end

  Section.where(year: 2014).delete_all
  arr = Convert.import_xml_file "sections2014.xml"
  Convert.from_hashes Section, arr, false
end
