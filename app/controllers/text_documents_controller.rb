class TextDocumentsController < ApplicationController
  before_filter :authenticate_user!
	before_filter :find_text_document, except: []
  
  def edit
    if request.xhr?
  		respond_to do |format|
  			format.html { render layout: false }
      end
    else
  		respond_to do |format|
  			format.html { render }
      end
    end
  end

  # PUT text_documents/1
  # PUT text_documents/1.json
  def update
    if request.xhr?
      respond_to do |format|
        if @doc.update_from_params(params[:text_document])
          format.html { redirect_to :back, notice: 'Document was saved.' }
        else
          format.json { render json: @doc.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @doc.update_from_params(params[:text_document])
          format.json { head :no_content }
          format.html { redirect_to :back, notice: 'TextDocument was successfully updated.' }
        else
          format.json { render json: @doc.errors, status: :unprocessable_entity }
          format.html { render action: "edit", error: 'Invalid parameters' }
        end
      end
    end
  end


  # # # GET text_documents
  # # GET text_documents.json
  # def index
  #   @docs = TextDocument.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @docs }
  #   end
  # end
  # 
  # # GET text_documents/1
  # # GET text_documents/1.json
  # def show
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @doc }
  #   end
  # end
  # 
  # # GET text_documents/new
  # # GET text_documents/new.json
  # def new
  #   @doc = TextDocument.new(params[:text_document])
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @doc }
  #   end
  # end
  # 
  # # GET text_documents/1/edit
  # def edit
  #   respond_to do |format|
  #     format.html { render :layout => !request.xhr? }
  #   end
  # end
  # 
  # # POST text_documents
  # # POST text_documents.json
  # def create
  #   @doc = TextDocument.new(params[:text_document])
  # 
  #   respond_to do |format|
  #     if @doc.save
  #       format.html { redirect_to text_document_url(@doc), notice: 'TextDocument was successfully created.' }
  #       format.json { render json: @doc, status: :created, location: @doc }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @doc.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  


  def ping
    respond_to do |format|
      format.any {render json: "pong", status: :ok}
    end
  end
  
  def unlock
    respond_to do |format|
      format.any {render json: "unlocked", status: :ok}
    end
  end
  
  # 
  # # DELETE text_documents/1
  # # DELETE text_documents/1.json
  # def destroy
  #   @doc.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to text_documents_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
	def find_text_document
   	@doc = TextDocument.find(params[:id])
	end
end
