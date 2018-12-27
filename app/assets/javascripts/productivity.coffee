# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  load_chart(chart_title, chart_data, y_axis_title)

load_chart = (chart_title, chart_data) ->
  Highcharts.chart 'highchart',
    chart: zoomType: 'x'
    title: text: chart_title 
    subtitle: text: if document.ontouchstart == undefined then 'Click and drag in the plot area to zoom in' else 'Pinch the chart to zoom in'
    xAxis: type: 'datetime'
    yAxis: title: text: y_axis_title 
    legend: enabled: false
    plotOptions: area:
      fillColor:
        linearGradient:
          x1: 0
          y1: 0
          x2: 0
          y2: 1
        stops: [
          [
            0
            Highcharts.getOptions().colors[0]
          ]
          [
            1
            Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')
          ]
        ]
      marker: radius: 2
      lineWidth: 1
      states: hover: lineWidth: 1
      threshold: null
    series: [ {
      type: 'area'
      name: 'Productivity'
      data: chart_data 
    } ]
