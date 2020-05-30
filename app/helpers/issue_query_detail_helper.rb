module IssueQueryDetailHelper
  def render_descendants_tree_issue_detail(issue)
    manage_relations = User.current.allowed_to?(:manage_subtasks, issue.project)
    s = +'<table class="list issues odd-even">'
    issue_list(
      issue.descendants.visible.
        preload(:status, :priority, :tracker,
                :assigned_to).sort_by(&:lft)) do |child, level|
      css = +"issue issue-#{child.id} hascontextmenu #{child.css_classes}"
      css << " idnt idnt-#{level}" if level > 0
      buttons = "".html_safe
      buttons << link_to_context_menu
      s <<
        content_tag(
          'tr',
             content_tag('td',
                         link_to_issue(
                           child,
                           :project => (issue.project_id != child.project_id)),
                         :class => 'subject') +
             content_tag('td', h(child.status), :class => 'status') +
             content_tag('td', link_to_user(child.assigned_to), :class => 'assigned_to') +
             content_tag('td', format_date(child.start_date), :class => 'start_date') +
             content_tag('td', format_date(child.due_date), :class => 'due_date') +
             content_tag('td',
                         (if child.disabled_core_fields.include?('done_ratio')
                            ''
                          else
                             progress_bar(child.done_ratio)
                          end),
                         :class=> 'done_ratio'),
          :class => css)
    end
    s << '</table>'
    s.html_safe
  end

  def render_issue_relations_issue_detail(issue, relations)
    s = ''.html_safe
    relations.each do |relation|
      other_issue = relation.other_issue(issue)
      css = "issue #{other_issue.css_classes}"
      buttons = "".html_safe
      buttons << link_to_context_menu
      s <<
        content_tag(
          'tr',
             content_tag('td',
                         relation.to_s(@issue) {|other|
                           link_to_issue(
                             other,
                             :project => Setting.cross_project_issue_relations?)
                         }.html_safe,
                         :class => 'subject') +
             content_tag('td', other_issue.status, :class => 'status') +
             content_tag('td', link_to_user(other_issue.assigned_to), :class => 'assigned_to') +
             content_tag('td', format_date(other_issue.start_date), :class => 'start_date') +
             content_tag('td', format_date(other_issue.due_date), :class => 'due_date') +
             content_tag('td',
                         (if other_issue.disabled_core_fields.include?('done_ratio')
                            ''
                          else
                            progress_bar(other_issue.done_ratio)
                          end),
                         :class=> 'done_ratio'),
          :id => "relation-#{relation.id}",
          :class => css)
    end
    content_tag('table', s, :class => 'list issues odd-even')
  end
end