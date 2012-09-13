class TextDocumentsController < ApplicationController
 	# before_filter :authenticate_user!
	before_filter :find_text_document, only: [:show, :edit, :update, :destroy]

 # GET text_documents
  # GET text_documents.json
  def index
    @text_documents = TextDocument.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_documents }
    end
  end

  # GET text_documents/1
  # GET text_documents/1.json
  def show
		if @text_document
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @text_document }
	    end
		else
			redirect_to root_url, notice: 'Invalid document'
		end
  end

  # GET text_documents/new
  # GET text_documents/new.json
  def new
    @text_document = TextDocument.new(params[:text_document])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_document }
    end
  end

  # GET text_documents/1/edit
  def edit
		unless @text_document
			redirect_to root_url, notice: 'Invalid document'
		end
  end

  # POST text_documents
  # POST text_documents.json
  def create
    @text_document = TextDocument.new(params[:text_document])

    respond_to do |format|
      if @text_document.save
        format.html { redirect_to text_document_url(@text_document), notice: 'TextDocument was successfully created.' }
        format.json { render json: @text_document, status: :created, location: @text_document }
      else
        format.html { render action: "new" }
        format.json { render json: @text_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT text_documents/1
  # PUT text_documents/1.json
  def update
		if @text_document
			respond_to do |format|
	      if @text_document.update_attributes(params[:text_document])
	        format.html { redirect_to text_document_url(@text_document), notice: 'TextDocument was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @text_document.errors, status: :unprocessable_entity }
	      end
	    end
		else
			logger.error "Tried to updated nonexistent document"
			redirect_to root_url
		end
  end

  # DELETE text_documents/1
  # DELETE text_documents/1.json
  def destroy
		unless @text_document
			logger.error "Tried to delete nonexistent document"
			redirect_to root_url, notice: 'Invalid document'
		end

    @text_document.destroy

    respond_to do |format|
      format.html { redirect_to text_documents_url }
      format.json { head :no_content }
    end
  end

	def find_text_document
		begin
    	@text_document = TextDocument.find(params[:id])
		rescue Mongoid::Errors::DocumentNotFound
			@text_document = nil
		end
	end
end
