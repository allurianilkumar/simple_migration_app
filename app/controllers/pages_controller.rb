class PagesController < ApplicationController
  
    layout "admin"

    before_action :confirm_logged_in

    def index
      @pages = Page.sorted
    end

    def show
      @page = Page.find(params[:id])
    end

    def new
      @page = Page.new({:name => "Default"})
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
    end

    def create
      # Instantiate a new object using form parameters
      @page = Page.new(params.require(:page).permit(:subject_id, :name, 
        :permalink, :position, :visible))
        # @pages = Page.new(subject_params)
        # Save the object
      if @page.save
        # If save Succeeds,redirect to the index ApplicationController
        flash[:notice] = "Page created successfully."
        redirect_to(:action => 'index')
        # If save fails ,redisplay the form so usre can fix problems
      else
        @subjects = Subject.order('position ASC')
        @page_count = Page.count + 1
        render('new')
        #redirect_to(:action => 'new')
      end
    end

    def edit
      @page = Page.find(params[:id])
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
    end

    def destroy
       page = Page.find(params[:id]).destroy
       flash[:notice] = "Page destroyed successfully."
       redirect_to(:action => 'index')
    end

    def update
      # Find an existing object  using form parameters
      @page = Page.find(params[:id])
      # Update the Object
      if  @page.update_attributes(params.require(:page).permit(:subject_id, :name, 
        :permalink, :position, :visible))
        # If update succeeds,redirect to the index ApplicationController
        flash[:notice] = "Page updated successfully."
        redirect_to(:action => 'show' , :id => @page.id)
      else
        #If update succeeds,redirect the form so user can fix problems
        @subjects = Subject.order('position ASC')
        @page_count = Page.count
        render('edit')
        #redirect_to(:action => 'new')
      end
    end

    def delete
        @page = Page.find(params[:id])
    end
  # private
  #    def subject_params
  #      params.require(:subject).permit(:name, :position, :visible)
  #    end
  # end
  def escape_output
    
  end
end
