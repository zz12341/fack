class BaseDocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy]
  include Hashable
  include SalesforceGptConcern

  # GET /documents or /documents.json
  def index
    @documents = Document.all.order(created_at: :desc)
    if params[:library_id].present?
      @library = Library.find(params[:library_id])
      @documents = @documents.where(library_id: params[:library_id])
    end

    @documents = @documents.page(params[:page])
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)
    @document.user_id = @current_user.id

    respond_to do |format|
      if @document.save
        EmbedDocumentJob.perform_later(@document.id)

        format.html { redirect_to document_url(@document), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    #@document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:document, :title, :url, :length, :library_id)
  end
end
