# Tsushin widget for ubersicht
# network throughput in kB
# Heavily inspired by Dion Munk's work network-throughput http://tracesof.net/uebersicht-widgets/#ubersicht-network-throughput

command: """
if [ ! -e tsushin.sh ]; then
  "$PWD/tsushin_small.widget/tsushin.sh"
else
  "$PWD/tsushin.sh"
fi
"""

# The refresh frequency in milliseconds
refreshFrequency: 2000

# Change container size to change the sizing of the chart
render: (domEl) -> """
<script src="https://code.highcharts.com/stock/highstock.js"></script>
<div id="container" style="width:420px; height:200px;">Loading...</div>    
"""
  
afterRender: (domEl) ->
  Highcharts.setOptions({
    global: {
      useUTC: false # UTC is set by default, disabling it triggers highcharts to pick up browser's local time
    }
  })
  
  $(domEl).find('#container').highcharts('StockChart'
    colors: ['#6fc3df', '#6fc3df']
    chart:   
      marginRight: 1
      marginTop: 1
      marginBottom: 8
      animation: Highcharts.svg
      useUTC: false
      backgroundColor: null
      style:
        color: 'rgba(126, 255, 255, 0.50)'
        fontFamily:'hack, Andale Mono, Menlo, Monaco, Courier, Helvetica Neue, Osaka'
        fontSize: '5px'
    navigator:
      enabled: false
    rangeSelector:
      enabled:false
      buttons:
        [{
        count: 5
        type: 'minute'
        text: '5M',
        },{
        connt: 10
        type: 'minute'
        text: '10M'
        },{
        type: 'all'
        text: 'All'
        }]
      enabled: false
      inputEnabled: false
      selected:0
      #inputEnabled: false
      #buttonTheme: visibility: 'hidden'
      #labelStyle: visibility: 'hidden'
      
    scrollbar:
      enabled:false

    title:
      text: 'Network throughput'
      enabled: true
      style:
        color: 'rgba(126, 255, 255, 0.50)'
        fontSize: '12px'
        fontWeight: 'normal'
        fontFamily:'hack, Courier, Helvetica Neue, Osaka, Monaco, Menlo'
#========================
    xAxis:
      type: 'datetime'
      dateTimeLabelFormats:
        hour: '%I :%p'
        minute: '%I:%M %p'
        useUTC: false
        #minTickInterval: 600
        #min: 90
        tickPixelInterval: 90
      minRange: 15*24
      labels:
        enabled: true
        #padding: -5
        y: 8
        style:
          color: 'rgba(126, 255, 255, 0.50)'
          fontSize: '8px'

      #gridLineColor: 'transparent'
#        null
      lineWidth: 0
      gridLineWidth: 0
      minorGridLineWidth: 0
      minorTickLenght: 0
      tickLength: 0
      lineColor: 'transparent'
      plotLines:[{
        width: 0
        value: 0
        color: 'rgba(126, 255, 255, 0.50)'
        }]
# ==================================
    yAxis:
      lineColor: 'transparent'          
      offset: -5
      title:
        text: null
        style: color: 'rgba(126, 255, 255, 0.50)'
      plotLines:[{
        value: 0
        width: 0.5
        color: '#6fc3df'
      }]
      labels:
        style:
          color: 'rgba(126, 255, 255, 0.50)'
          fontSize: '8px'
        y: 7

      #tickPosition:"inside"      
      #padding: 0
      #stackLabels: true
      #reserveSpace: false
      showFirstLabel: false
      showLastLabel: true
      gridLineColor: 'rgba(126, 255, 255, 0.20)'

      legend:
        enabled: false
        verticalAlign: 'top'
        # align: 'top'
        floating: true

# ==========================
# Here is where you put data
# Dynamically fed by update code below
    series: [ {
      name: 'Down (kB)'
      lineWidth: 1
      color: '#6fc3df'
      data: []
      },
      {
       name: "Up (kB)"
       lineWidth: 1
       color:"#ffe64d"
       data:[]
        }]
      
    credits:
      enabled: false
  )

update:(output,domEl) ->
  #How to dynamically update data for highcharts/stock    #http://stackoverflow.com/questions/16061032/highcharts-series-data-array  #http://stackoverflow.com/questions/13049977/how-can-i-get-access-to-a-highcharts-chart-through-a-dom-container
  #http://api.highcharts.com/highstock/Series.addPoint()
  @run '''
    if [ ! -e tsushin.sh ]; then
      "$PWD/tsushin_small.widget/tsushin.sh"
    else
      "$PWD/tsushin.sh"
    fi
   ''', (err, output) ->

      data=output.split(" ");
      dataIn = parseFloat(data[0]);
      dataOut = parseFloat(data[1]);
      chart=$(domEl).find("#container").highcharts();
      time= (new Date).getTime();
      #timeData = time + i * 10000;  
      chart.series[0].addPoint([time, dataIn], true);
      chart.series[1].addPoint([time, dataOut], true);
      
# the CSS style for this widget, written using Stylus
# (http://learnboost.github.io/stylus/)
style: """
  @font-face
    font-family: 'hack'
    src: url('assets/hack.ttf')

  color: #6fc3df
  font-family: hack, Courier, Helvetica Neue, Osaka, Monaco, Menlo
  font-weight: 100
  bottom: 5%
  right: 30px
  text-shadow: 0 0 1px rgba(#000, 0.5)
  font-size: 15px
  white-space: pre
  #container
    -webkit-backdrop-filter: blur(4px)
"""
