class Api::V1::ProjectsController < Api::V1::BaseController

  def create
    @project = Project.create!(project_params)
    render @project
  end
  
  private

  def project_params
    params.require(:project).permit(:name)
  end
end
