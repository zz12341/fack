class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update destroy]
  before_action :set_chat

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show; end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit; end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.chat_id = @chat.id
    @message.user_id = @current_user.id

    respond_to do |format|
      if @message.save
        GenerateMessageResponseJob.set(priority: 1).perform_later(@message.id)

        format.html { redirect_to @chat}
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:chat_id, :content, :from)
  end
end
