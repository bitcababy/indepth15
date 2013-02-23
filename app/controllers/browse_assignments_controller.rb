class BrowseAssignmentsController < ApplicationController
  # STARTING_PER_PAGE = 15
  # 
  # def browse
  #   @sas = []
  # end
  # 
  # def retrieve_for_browsing
  #   # logger.warn params
  #   sas = get_sas_from_params
  #   ret = Hash.new
  #   sColumns = params[:sColumns].split(',')
  #   ret[:iTotalRecords] = sas.count
  #   ret[:iTotalDisplayRecords] = sas.count # This doesn't take filtering into account
  #   ret[:sEcho] = params[:sEcho]
  #   ret[:sColumns] = sColumns
  #   ret[:aaData] = []
  #   sas.each do |sa|
  #     ret[:aaData] << sColumns.collect { |col| sa.send(col) }
  #   end
  #   logger.warn ret
  # 
  #   render json: ret, status: :success
  # end
  #   
  # protected
  # def get_sas_from_params
  #   iColumns = params[:iColumns].to_i
  #   sColumns = params[:sColumns].split(',')
  #   iDisplayStart = params[:iDisplayStart].to_i
  #   iDisplayLength = params[:iDisplayLength].to_i
  #   aSearch = params[:aSearch]
  #   colRange = 0..(iColumns - 1)
  #   bSortables = colRange.collect { |i| params["bSortable_#{i.to_s}"] == "true" }
  #   # iSortCol = colRange.collect {|i| params["iSortCol_#{i}"] == "true"}
  #   sSortDir = colRange.collect { |i| bSortables[i] ? params["sSortDir_#{i.to_s}"].upcase : nil }
  #   direct_sort = sColumn & 
  #   order = colRange.collect { |i|
  #     bSortables[i] ? "#{sColumns[i] + " " + sSortDir[i]}" : nil
  #   }
  #   order = order.compact.join(',')
  #     
  #   return SectionAssignment.limit(iDisplayLength).skip(iDisplayStart)
  # end
end
