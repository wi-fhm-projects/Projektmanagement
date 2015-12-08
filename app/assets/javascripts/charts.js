$(document).ready(function(){
  if (typeof code_happened === 'undefined') {
  window.code_happened = true;
    google.charts.load('current', {packages:["orgchart"]});
  }
});

function drawPBS(name, parent, tooltip){
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Name');
    data.addColumn('string', 'Manager');
    data.addColumn('string', 'ToolTip');
    var chart = new google.visualization.OrgChart(document.getElementById('pbs_div'));

    data.addRows([
      [name, parent, tooltip],
    ]);

    chart.draw(data, {allowHtml:true});
}
