class RedmineIssueQueryDetailViewHookListener < Redmine::Hook::ViewListener
  
  render_on :view_issues_index_bottom, :partial => "issue_query_detail/hooks/view_buttons" 
end
