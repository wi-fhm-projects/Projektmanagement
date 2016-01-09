class RamController < ApplicationController



  def index
   @project = Project.find(params[:project])
   @allocationItem = Allocationitem.new
   roles_select
   components_select
  end

  private

    def roles_select
      @roles = Array.new
      @project.kinds.each do |kind|
        kind.roles.each do |role|
          @roles.push(role)
        end
      end
    end

    def components_select
      @components = Array.new
      @project.subproducts.each do |subproduct|
        subproduct.moduls.each do |modul|
          modul.components.each do |component|
            @components.push(component)
          end
        end
      end
    end
end
