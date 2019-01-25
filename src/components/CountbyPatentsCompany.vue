<template>
    <div class="content">
        <div id="myChart6" class="chart-container" >
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
//require('echarts/lib/chart/line');
require('echarts/lib/chart/bar');
require('echarts/lib/component/tooltip');
require('echarts/lib/component/toolbox');
require('echarts/lib/component/legend');
require('echarts/lib/component/markLine');
require('echarts/lib/component/dataZoom');

export default {
  data () {
    return {
      field :[],
      name : [],
      data1 :[],

    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    async drawLine(){
        /** 请求图表数据 */
        const { data } = await this.$axios.get("/bar");
        this.field = data.testdata.field;
        this.name = data.testdata.name;
        this.data1 = data.testdata.data;
        let name1 = this.name[0];
        let name2 = this.name[1];
        let number1 = [];
        let number2 = [];
        for(let i=0;i<this.data1.length;i++){
        number1.push(parseFloat(this.data1[i][0]));
        number2.push(parseFloat(-this.data1[i][1]));
        }

        let data1max = Math.max.apply(null,number1);
        let data2max = Math.max.apply(null,number2);
        
        console.log(data1max);
        // 基于准备好的dom，初始化echarts实例
        let Chart = echarts.init(document.getElementById('myChart6'));
        // 绘制图表
        Chart.setOption({
            toolbox: {
                show : true,
                feature : {
                    saveAsImage : {show: true}
                },
                right : '15%',
                top:'5%',
            },
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            },
            formatter: function(params){
                var reval= params[0].name+"<br/>";
                reval+=params[0].seriesName+':'+(-params[0].value)+"<br/>";
                reval+=params[1].seriesName+':'+(params[1].value)+"<br/>";
            }
            },
            legend: {
               data:[name1,name2],
               top:'5%'
            },
            grid: {
               left: '3%',
               right: '4%',
               bottom: '3%',
               containLabel: true
            },
            xAxis : [
            {
            type : 'value',
            min:(function(){
                        if(data1max>= Math.abs(data2max) )
                            return -data1max;
                        else
                            return data2max;
                    })(),
            axisLabel:{
              formatter:function(value){
                if (value<0){
                  return -value;
                }
                else return value;
              }
            },
            splitNumber:8,
            }
            ],
            yAxis : [
            {
            type : 'category',
            axisTick : {show: false},
            data : this.field,
            axisLine: {
            show: false
            },
            
           }
           ],
           series : [
            {
            name:name1,
            type:'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'right',
                    fontSize:16,
                    color:['#336699'],
                }
            },
            data:number1,
            color:['#336699']
            },
           {
            name:name2,
            type:'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'left',
                    formatter:function(value){
                        if(value.data<0){
                            return -value.data;
                       }
                    else return value.data;
                },
                fontSize:16,
                color:['#336699'],
                }
            },
            data:number2,
            color:['#B0E0E6']
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