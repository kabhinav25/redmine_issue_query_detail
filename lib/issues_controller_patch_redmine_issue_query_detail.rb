module IssuesControllerPatchRedmineIssueQueryDetail
  def self.included(base)
    base.send(:prepend, InstanceMethods)
  end

  module InstanceMethods
    def index
      if !params[:modern_view] || %w(api atom csv pdf).include?(params[:format])
        super
      else
        use_session = true
        retrieve_query(IssueQuery, use_session)
        if @query.valid?
          @issue_count = @query.issue_count
          @issue_pages = IssuesController::Paginator.new @issue_count, per_page_option, params['page']
          @issues = @query.issues(:offset => @issue_pages.offset, :limit => @issue_pages.per_page)
        end
        render "redmine_issue_query_detail/index"
      end
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end

IssuesController.send(:include, IssuesControllerPatchRedmineIssueQueryDetail)