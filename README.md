# redmine_issue_query_detail (BETA)

Redmine Plugin to show issue details on the Issue Query Page.

<b>Compatibility</b> : Redmine 4.1+ versions.(I can develop for Redmine 3.x versions if people need it.)

<b>Note</b>: The plugin is still in very early development stage. Active feedback will help in better development of the plugin. Use the github `Issues` to report any bug or feature requests.

# Installation

1. Copy the plugin directory into the $REDMINE_ROOT/plugins directory.
2. Restart Redmine.

# Usage

The plugin can be used directly without needing to run any migrations or providing permissions.

The issue query page will show two links to choose the view for query result:

1. classic view - this is the current view used in issue query
2. modern view - lists all the issues from the query result. Selecting an issue will load up its details.