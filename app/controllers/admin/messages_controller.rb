module Admin
    class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    def new
        @message = Message.new
    end

    def create
        # @message = Message.create(msg_params)
        @message = current_user.messages.create(msg_params)
        if @message.save
            ActionCable.server.broadcast('room_channel', 
                {mod_message: message_render(@message)})
            # ActionCable.server.broadcast('room_channel', 
            #                             {content: @message.content})
        end
    end

    private 
    def msg_params
        params.require(:message).permit(:content, :user_id, :chatroom_id)
    end

    def message_render(message)
        if !current_user.admin?
            render(partial: 'admin/messages/message', locals: {message: message})
        else
            render(partial: 'admin/messages/message2', locals: {message: message})
        end
    end

    # 
    # def message_render(message)
    #     render(partial: 'message', locals: {message: message})
    # end
    # 

    protected
    # redirect if user not logged in or does not have a valid role
    def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
    end

    end
end
