<template>
    <div class="content">
        <div id="myChart7" class="chart-container" >
     </div>   
    </div>
</template>

<script>
import '../../node_modules/echarts/map/js/world.js';
import '../../node_modules/echarts/map/json/world.json';
let echarts = require('echarts/lib/echarts');
//require('echarts/lib/chart/line');
require('echarts/lib/chart/map');
require('echarts/lib/component/tooltip');
require('echarts/lib/component/toolbox');
require('echarts/lib/component/legend');
require('echarts/lib/component/markLine');
require('echarts/lib/component/dataZoom');

export default {
  data () {
    return {
      mapdata :[],
    
    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    async drawLine(){
        /** 请求图表数据 */
        const { data } = await this.$axios.get("/map");
        this.mapdata = data.testdata.data;

        // 基于准备好的dom，初始化echarts实例
        let Chart = echarts.init(document.getElementById('myChart7'));
        // 绘制图表
        Chart.setOption({
        backgroundColor: 'white',
        title : {
                x: 'center',
                align: 'right'
            },
        tooltip: {
            trigger: 'item',
            showDelay: 0,
            transitionDuration: 0.2,
            formatter: function (params) {
                 if (params.data){
                   let value = (params.value + '').split('.');
                   value = value[0].replace(/(\d{1,3})(?=(?:\d{3})+(?!\d))/g, '$1,');  
                   return params.seriesName + '<br/>' + params.name + ': ' + value; 
                }
                else
                    return "No Data";
                
            }
        },
        visualMap: {
            left: 'right',
            min: 0,
            max: 500000000,
            inRange: {
                color: ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
            },
            text:['High','Low'],           // 文本，默认为数值文本
            calculable: true
        },
        toolbox: {
            show: true,
            //orient: 'vertical',
            //left: 'right',
            right: '10%',
            top: '5%',
            feature: {
                dataView: {readOnly: false},
                restore: {},
                saveAsImage: {}
            }
        },
        series: [
            {
                name: 'The Number of Patents',
                type: 'map',
                roam: true,
                map: 'world',
                itemStyle:{
                        areaColor: '#B0C4DE',
                        borderColor: '#B0C4DE'
                },
                emphasis:{                   
                    label:{show:true,fontSize:16},
                    itemStyle:{areaColor: '#ffee51',
                    borderColor: '#ffee51'}
                },
                // 文本位置修正
                textFixed: {
                    
                },
                data:this.mapdata
         }   
        ],
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