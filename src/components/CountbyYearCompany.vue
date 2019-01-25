<template>
    <div class="content">
        <div id="myChart2" class="chart-container" >
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
require('echarts/lib/chart/line');
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
      data1 :[],
      data2: [],
      name1 :[], 
    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    async drawLine(){
        /** 请求图表数据 */
        const { data } = await this.$axios.get("/line2");
        this.year = data.testdata.index;
        this.data1 = data.testdata.data1;
        this.data2 = data.testdata.data2;
        this.name1 = data.testdata.name;
        console.log(this.year);
        console.log(this.data1);
        let data1max = Math.max.apply(null, this.data1);
        let data2max = Math.max.apply(null, this.data2);
        console.log(data1max);
        // 基于准备好的dom，初始化echarts实例
        let Chart = echarts.init(document.getElementById('myChart2'));
        // 绘制图表
        Chart.setOption({
             title : {
                x: 'center',
                align: 'right'
            },
            grid: {
                bottom: 80,
            },
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
                    data:this.year,
                }
            ],
          yAxis: [
                {
                    name: '专利数量',             
                    max:(function(){
                        if(data1max>= data2max) 
                            return data1max;
                        else
                            return data2max;
                    })(),//设置y轴最大值
                    type: 'value',
                  
                },
                
            ],
    series: [
                {
                    name:this.name1[0],//设置y1的name
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
                    data:this.data1,//设置y1数据

                },  
                 {
                    name:this.name1[1],//设置y2的name
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
                    data:this.data2//设置y2数据
                    
                },  
            ],
    color:["#001852","#93b7e3"]
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