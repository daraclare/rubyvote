class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_poll
  before_action :set_kind_questions
  before_action :authenticate_user!, except: [ :index ]
  
  
  # before_action :admin!, except: [ :index ]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = @poll.questions.build
    0.times { @question.possible_answers.build }
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = @poll.questions.build(question_params)
    @question.title = @question.title.censor

    respond_to do |format|
      if @question.save
        format.html { redirect_to @poll, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to @poll, notice: 'Question was deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :kind, :poll_id, { possible_answers_attributes: [ :title, :question_id ] })
    end

    def set_kind_questions
      @kind_options = [
        ["Open Answer", "open" ],
        [ "Multiple Choice", "choice" ],
      ]
    end

    def set_poll
      @poll = Poll.find params[:poll_id]
      
    end

    # devise authenication
    def admin!
      authenticate_user!

      redirect_to root_path, notice: "Please log in as an administrator before continuing" unless current_user.admin? 
    end
end
