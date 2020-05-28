require_dependency 'redmine_issue_query_detail_view_hook_listener'
require_dependency 'issues_controller_patch_redmine_issue_query_detail'

Redmine::Plugin.register :redmine_issue_query_detail do
  name 'Redmine Issue Query Detail'
  author 'Kumar Abhinav'
  description 'View issue details in issue query page'
end
