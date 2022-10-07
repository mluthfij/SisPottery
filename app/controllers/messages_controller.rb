class MessagesController < ApplicationController
    before_action :authenticate_user!
    
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
            render(partial: 'message', locals: {message: message})
        else
            render(partial: 'message2', locals: {message: message})
        end
    end

    # 
    # def message_render(message)
    #     render(partial: 'message', locals: {message: message})
    # end
    # 

end
