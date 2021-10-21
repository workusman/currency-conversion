json.project do
  json.partial! "project", project: @project if @project.present?
end
