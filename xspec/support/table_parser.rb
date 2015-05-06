module CapybaraExtras
  def table_headers(table, as_text: true)
    cells = table.all('th')
    return cells unless as_text    
    return cells.collect { |th| th.text }
  end

  def table_cells(table, as_text: true, include_headers: false)
    cells = table.all('tr').collect do |row|
      if include_headers && row.has_xpath?('th')
        row.all('th')
      elsif row.has_xpath?('td')
        row.all('td')
      else
        nil
      end
    end
    cells.compact!
    return cells.compact unless as_text
    return cells.collect do |row|
      row.collect {|c| c.text }
    end
  end
end
