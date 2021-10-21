class Api::V1::ProjectsController < Api::V1::BaseController
  
  skip_before_action :authenticate_request!, only: [:create]

  def create
    @project = Project.create!(project_params)
    render @project
  end
  
  private

  def project_params
    params.require(:project).permit(:name)
  end
end
