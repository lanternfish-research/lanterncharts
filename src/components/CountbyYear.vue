<template>
    <div class="content">
        <div ref="Chart" class="chart-container">
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
require('echarts/lib/chart/line');
require('echarts/lib/component/tooltip');
require('echarts/lib/component/toolbox');
require('echarts/lib/component/legend');
require('echarts/lib/component/markLine');
require('echarts/lib/component/dataZoom');
export default {
  data () {
    return {
         mychart:null,
         option:{ 
           title : {
                x: 'center',
                align: 'right'
            },
            grid:{},
            toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: ['bar'],
                        
                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                },
                right : '15%',
                top:'5%',
            },
            tooltip : {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    animation: false,
                    label: {
                        backgroundColor: '#505765'
                    }
                }
            },
            legend: {
                data:name,//设置图例
                x: '20%',
                y:'5%'
            },
            dataZoom: [
                {
                    show: true,
                    type: 'inside',
                    realtime: true,
                    start: 0,
                    end: 100
                },
                  {
                    type: 'slider',
                    show: true,
                    xAxisIndex: [0],
                    start: 40,
                    end: 100
                },
            ],
           xAxis : [
                {
                    name: '年份',
                    nameLocation:'start',
                    type : 'category',
                    boundaryGap : false,
                    axisLine: {onZero: false},
                    data:[2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018],//设置x轴
                }
            ],
          yAxis: [
                {
                    name: '专利数量',                
                    max:452,//设置y轴最大值
                    type: 'value',
                  
                },
                
            ],
          series: [
                {
                    name:"专利数量",
                    type:'line',
                    animation: false,
                    areaStyle: {
                        normal: {}
                    },
                    lineStyle: {
                        normal: {
                            width: 1
                        }
                    },
                    data:[2, 48, 32, 34, 62, 20, 29, 48, 58, 106, 64, 452, 43],//设置y轴

                },   
            ],
          color:["#001852"]
         }

    }
  },
mounted(){

     this.initEcharts();
        },

 updated(){
    this.drawLine();
  },
  methods: {
    initEcharts(){
       this.mychart = echarts.init(this.$refs.Chart);
       this.mychart.setOption(this.option);
    },
        
    drawLine(){
        this.mychart.setOption(this.option);
        window.onresize = function(){
           this.mychart.resize();
        }
    }
  }
};
</script>

<style lang='less' scoped>
.content {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 400px;
    border: 1px solid #efefef;
    padding: 20px;

    a {
        padding: 0 0.5em;
    }
}

.chart-container {
    width:100%;
    height:500px;
}
</style>