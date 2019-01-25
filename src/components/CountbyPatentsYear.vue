<template>
    <div class="content">
        <div id="myChart3" class="chart-container" >
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
require('echarts/lib/chart/scatter');
require('echarts/lib/chart/bar');
require('echarts/lib/component/tooltip');
require('echarts/lib/component/toolbox');
require('echarts/lib/component/legend');
require('echarts/lib/component/markLine');
require('echarts/lib/component/dataZoom');

export default {
  data () {
    return {
      year :[],
      field :[],
      data1 :[],

    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    async drawLine(){
        /** 请求图表数据 */
        const { data } = await this.$axios.get("/scatter");
        this.year = data.testdata.years;
        this.field = data.testdata.fields;
        this.data1 = data.testdata.data;
        let field = this.field;
        let data1 = this.data1;
        let year = this.year;
        let data1max=109;//求最大值
        let data1min=1;//求最小值
        // 基于准备好的dom，初始化echarts实例
        let Chart = echarts.init(document.getElementById('myChart3'));
        // 绘制图表
        Chart.setOption({
        legend: {
        data: ['专利数量'],
        left: '20%',
        top:'5%',
        },
        toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    saveAsImage : {show: true},
                    restore : {show: true},
                },
                right : '15%',
                top:'5%',
            },
        dataZoom: [{
        show: true,
        start: 0,
        end: 100
        },
        {
        type: 'inside',
        xAxisIndex: 0,
        start: 50,
        end: 100
        },
        {
            type: 'inside',
            yAxisIndex: 0,
            //filterMode: 'empty',
            start: 0,
            end: 100
        }
        ],
        tooltip: {
        
        position: 'top',
        formatter: function (params) {
            return field[params.value[1]]+':'+params.value[2] +'(' + year[params.value[0]] +'年)';
                    }
        
        },
        grid: {
        left: '10%',
        bottom: '10%',
        right: '10%',
        containLabel: true
        },
        xAxis: {
        type: 'category',
        data: year,
        boundaryGap: false,
        splitLine: {
            show: true,
            lineStyle: {
                color: '#999',
                type: 'dashed'
            }
        },
        axisLine: {
            show: false
         }
        },
        yAxis: {
        type: 'category',
        data: field,
        axisLine: {
            show: false
        },
        splitLine: {
            show: false,
            lineStyle: {
                color: '#999',
                type: 'dashed'
              }
            },
        },
        series: [{
        name: '专利数量',
        type: 'scatter',
        symbolSize:function (val) {
           if(val[2]==data1min)
                return 8;
           if(val[2]==data1max)
                return 50;
           else
                return 8+42*(val[2]-data1min)/(data1max-data1min);
        },

        data: data1,
        showEffectOn: 'emphasis',
        animationDelay: function (idx) {
            return idx * 5;
        },
        showEffectOn: 'render',
        rippleEffect: {
                brushType: 'stroke'
        },
        hoverAnimation: true,
        itemStyle: {
                normal: {
                    color: '#336699',
                    shadowBlur: 10,
                    shadowColor: '#336699'
                }
            },
           
    }],
},true);
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
    height:400px;
    width: 100%;
}
</style>