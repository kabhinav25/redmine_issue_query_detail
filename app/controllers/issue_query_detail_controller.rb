class IssueQueryDetailController < IssuesController

  skip_before_action :authorize
  before_action :find_issue

  def issue_detail
    @journals = @issue.visible_journals_with_index
    @has_changesets = @issue.changesets.visible.preload(:repository, :user).exists?
    @relations = @issue.relations.select {|r| r.other_issue(@issue) && r.other_issue(@issue).visible? }

    @journals.reverse! if User.current.wants_comments_in_reverse_order?

    if User.current.allowed_to?(:view_time_entries, @project)
      Issue.load_visible_spent_hours([@issue])
      Issue.load_visible_total_spent_hours([@issue])
    end

    @allowed_statuses = @issue.new_statuses_allowed_to(User.current)
    @priorities = IssuePriority.active
    @time_entry = TimeEntry.new(:issue => @issue, :project => @issue.project)
    @time_entries = @issue.time_entries.visible.preload(:activity, :user)
    @relation = IssueRelation.new
  end
end