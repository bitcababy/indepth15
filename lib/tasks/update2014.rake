task :update2014 => :environment do
  require Rails.root.join('import/convert')

  t = Teacher.find 'abendb'
  t.current = false
  t.save!
  
  if Teacher.where(_id: 'hamavida').exists?
    t = Teacher.find(_id: 'hamavida')
    t.delete
  end
  Teacher.create! current: true, last_name: 'Hamavid', first_name: 'Aviva', \
    title: 'Ms', password: 'IssIutng', login: 'hamavida', email: 'hamavida@mail.weston.org'
  Section.where(year: 2014).delete_all
  arr = Convert.import_xml_file "sections2014.xml"
  Convert.from_hashes Section, arr, false
end
