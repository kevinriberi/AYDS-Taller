class AnswerController < Sinatra::Application
    # Define la ruta y el método HTTP explícitamente
    post '/answers' do
      @answer = Answer.new(answer_params)
      if @answer.save
        flash[:success] = "Answer saved successfully!"
        redirect_to root_path
      else
        flash[:error] = "Answer not saved"
        render :new
      end
    end
    
    private
  
    def answer_params
      params.require(:answer).permit(:user_id, :question_id, :option_id)
    end
end
  