$( document ).ready(function() {
  $("#selectable").selectable({
    filter: $('.select-issue'),
      selected: function( event, ui ) {
        $.ajax({
          url: "issue_query_detail/" + ui.selected.dataset["issueId"],
          type: 'get',
          dataType: 'script'
        });
      }
  });



});

function showIssueHistoryQueryDetail(journal, url) {
  tab_content = $('#tab-content-history');
  tab_content.parent().find('.tab-content').hide();
  tab_content.show();
  tab_content.parent().children('div.tabs').find('a').removeClass('selected');

  $('#tab-' + journal).addClass('selected');

  // replaceInHistory(url)

  switch(journal) {
    case 'notes':
      tab_content.find('.journal:not(.has-notes)').hide();
      tab_content.find('.journal.has-notes').show();
      break;
    case 'properties':
      tab_content.find('.journal.has-notes').hide();
      tab_content.find('.journal:not(.has-notes)').show();
      break;
    default:
      tab_content.find('.journal').show();
  }

  return false;
}

function getRemoteTabQueryDetail(name, remote_url, url, load_always) {
  load_always = load_always || false;
  var tab_content = $('#tab-content-' + name);

  tab_content.parent().find('.tab-content').hide();
  tab_content.parent().children('div.tabs').find('a').removeClass('selected');
  $('#tab-' + name).addClass('selected');

  // replaceInHistory(url);

  if (tab_content.children().length == 0 && load_always == false) {
    $.ajax({
      url: remote_url,
      type: 'get',
      success: function(data){
        tab_content.html(data)
      }
    });
  }

  tab_content.show();
  return false;
}