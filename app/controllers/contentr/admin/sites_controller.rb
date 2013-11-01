class Contentr::Admin::SitesController < Contentr::Admin::ApplicationController
  def new
    @site = Contentr::Site.new
  end

  def create
    @site = Contentr::Site.new(site_params)
    @site.parent = nil

    if @site.save
      flash.now[:success] = 'Site created.'
      redirect_to contentr_admin_pages_path()
    else
      render :action => :new
    end
  end

  def destroy
    site = Contentr::Site.find(params[:id])
    site.destroy
    redirect_to contentr_admin_pages_path(:root => @root_page)
  end

  protected
    def site_params
      params.require(:site).permit(*Contentr::Site.permitted_attributes)
    end

end
