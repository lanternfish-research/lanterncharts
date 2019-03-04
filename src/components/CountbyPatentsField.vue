<template>
    <div class="content">
        <div id="myChart4" class="chart-container" >
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
require('echarts/lib/chart/graph');
//require('echarts/lib/chart/bar');
require('echarts/lib/component/tooltip');
require('echarts/lib/component/toolbox');
require('echarts/lib/component/legend');
require('echarts/lib/component/markLine');
require('echarts/lib/component/dataZoom');

export default {
  data () {
    return {
      ipcdata :[],
      cate :[],

    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    async drawLine(){
        /** 请求图表数据 */
        const { data } = await this.$axios.get("/gragh");
        this.ipcdata = data.testdata.data;
        this.cate = data.testdata.cate;
        let ipcdata = this.ipcdata;
        let nodes = [];
        let categories = [];
        //for (let i=0; i<this.cate.length;i++){
        for (let i=0; i<this.cate.length;i++){
            categories[i]= {
            name: this.cate[i],
            }
        } 
        let data1min=1;
        let data1max=84;  
        //for (let i=0; i<ipcdata.length;i++){
        for (let i=0; i<31;i++){
            nodes[i]={
              name: ipcdata[i][0],
              value:(function(){
                if(ipcdata[i][1]==data1min)
                    return 8;
                if(ipcdata[i][1]==data1max)
                    return 50;
                else
                    return 8+42*(ipcdata[i][1]-data1min)/(data1max-data1min);
              })(),
              category:ipcdata[i][2],
              symbolSize:(function(){
                if(ipcdata[i][1]==data1min)
                    return 8;
                if(ipcdata[i][1]==data1max)
                    return 50;
                else
                    return 8+42*(ipcdata[i][1]-data1min)/(data1max-data1min);
              })(),
              label:{
              normal: {
                show: ipcdata[i][1]>(data1max-data1min)*2/3+data1min,
                 }
              },
              itemStyle: null,
           }
        }     
        // 基于准备好的dom，初始化echarts实例
        let Chart = echarts.init(document.getElementById('myChart4'));
        // 绘制图表
        Chart.setOption({
        tooltip: {},
        toolbox: {
                show : true,
                feature : {
                    restore : {show: true},
                    saveAsImage : {show: true},
                },
                right : '10%',
                top:'3%',
            },
        legend: [{
            // selectedMode: 'single',
            data: categories.map(function (a) {
                return a.name;
            })
        }],
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'quinticInOut',
        series : [
            {
                name: '专利IPC',
                type: 'graph',
                layout: 'circular',
                circular: {
                    rotateLabel: true,
                    },
                data: nodes,
                categories: categories,
                roam: true,
                label: {
                    normal: {
                        position: 'right',
                        formatter: '{b}'
                    }
                },
                color:['#003366','#006699','#0099CC','#336699','#6699CC','#87CEEB','#4A708B','#7EC0EE','#B0E2FF','#4682B4'],
                tooltip:{formatter: function(params){
                  var showvalue = params.data.value;
                  var truevalue = Math.round((showvalue-8)/42*(data1max-data1min)+data1min);
                  var str = params.seriesName+'</br>'+params.marker +'&nbsp;' +params.data.name+':'+ truevalue;
                  return str;
                }},
            }
        ]
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