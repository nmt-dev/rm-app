class Requestor::JobsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_requestor

    def index
        @jobs = current_user.jobs
    end

    def show
        @current_user_jobs = current_user.jobs
        @job = @current_user_jobs.find params[:id]
        
        if @job.evaluation != nil
            @response_time = convert_rating(@job.evaluation.response_time)           
            @quality = convert_rating(@job.evaluation.quality)           
            @courtesy = convert_rating(@job.evaluation.courtesy)
            @comments = @job.evaluation.comments           
        end
    end

    def new
        @job = current_user.jobs.build
    end

    def create
        @job = current_user.jobs.build(jobs_params)
        respond_to do |format|
            if  @job.save
                format.html { redirect_to requestor_job_path(@job), notice: "Job Order was successfully created." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    private

    def jobs_params
        params.require(:job).permit(:nature_of_request, :note_to_staff)
    end

    def convert_rating(rating)
        case self
        when 1
            'Poor'
        when 2
            'Moderately Satisfactory'
        when 3
            'Satisfactory'
        when 4
            'Highly Satisfactory'
        else 5
            'Outstanding'
        end
    end
end
