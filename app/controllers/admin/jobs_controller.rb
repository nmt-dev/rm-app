class Admin::JobsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin
    
    def index
        @jobs = Jobs.all
    end

    def show
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end
    
end