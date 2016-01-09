class SubproductsController < ApplicationController
  before_action :find_product, only: [:destroy, :show]

  def index
    @subproducts = Subproduct.all
  end

  def show
  end

  def create
    @subproduct = Subproduct.new(product_params)
    @project = Project.find(product_params[:project_id])
    respond_to do |format|
      if @subproduct.save
        format.html { redirect_to pbs_path(project: @project) , success: 'Teilprodukt wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @subproduct }
      else
        format.html { redirect_to pbs_path(project: @project), danger: 'Teilprodukt nicht erstellt' }
        format.json { render json: @subproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = @subproduct.project
    @subproduct.destroy
    respond_to do |format|
      format.html { redirect_to pbs_path(project: @project), success: 'Teilproduct wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @subproduct = Subproduct.new
  end

  private

    def find_product
      @subproduct = Subproduct.find(params[:id])
    end

    def product_params
      params.require(:subproduct).permit(:name, :description, :project_id)
    end
end
