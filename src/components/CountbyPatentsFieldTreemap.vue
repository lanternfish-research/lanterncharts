<template>
    <div class="content">
        <div id="myChart8" class="chart-container" >
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
require('echarts/lib/chart/treemap');
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
        let cate = this.cate;
        var diskData=[];
        for (let i=0; i<cate.length;i++){
        diskData[i]={
        value:200/(i+1),
        name:cate[i],
        children:[],
         }
        };
       for (let i=0;i<ipcdata.length;i++){
       var category=ipcdata[i][2];
       var n=ipcdata[i][0];
       var v=ipcdata[i][1];
       for (let j=0;j<cate.length;j++){
        if(cate[j]==category){
            diskData[j].children.push({
                name:n,
                value:v,
            })}
        else
            continue;
    }
};
let Chart = echarts.init(document.getElementById('myChart8'));
function colorMappingChange(value) {
        var levelOption = getLevelOption(value);
        chart.setOption({
            series: [{
                levels: levelOption
            }]
        });
    };
var formatUtil = echarts.format;

function getLevelOption() {
        return [
            {
                itemStyle: {
                    normal: {
                        borderWidth: 0,
                        gapWidth: 5
                    }
                }
            },
            {
                itemStyle: {
                    normal: {
                        gapWidth: 1
                    }
                }
            },
            {
                colorSaturation: [0.35, 0.5],
                itemStyle: {
                    normal: {
                        gapWidth: 1,
                        borderColorSaturation: 0.6
                    }
                }
            }
        ];
    };
        // 基于准备好的dom，初始化echarts实例

        // 绘制图表
        Chart.setOption({
        title: {
            text: 'The Number of Patents in Each IPC Field',
            left: 'center'
        },
        toolbox: {
                show : true,
                feature : {
                    restore : {show: true},
                    saveAsImage : {show: true},
                },
                right : '10%',
                top:'3%',
            },
        tooltip: {
            formatter: function (info) {
                var value = info.value;
                var treePathInfo = info.treePathInfo;
                var treePath = [];

                for (var i = 1; i < treePathInfo.length; i++) {
                    treePath.push(treePathInfo[i].name);
                }

                return [
                    '<div class="tooltip-title">' + formatUtil.encodeHTML(treePath.join('/')) + '</div>',
                    'The Number of Patents: ' + formatUtil.addCommas(value) ,
                ].join('');
            }
        },

        series: [
            {
                name:'The Number of Patents in Each IPC Field',
                type:'treemap',
                visibleMin: 300,
                label: {
                    show: true,
                    formatter: '{b}'
                },
                itemStyle: {
                    normal: {
                        borderColor: '#fff'
                    }
                },
                levels: getLevelOption(),
                data: diskData
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