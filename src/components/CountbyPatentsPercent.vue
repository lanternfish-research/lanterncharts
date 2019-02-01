<template>
    <div class="content">
        <div id="myChart5" class="chart-container" >
     </div>   
    </div>
</template>

<script>
let echarts = require('echarts/lib/echarts');
require('echarts/lib/chart/pie');
//require('echarts/lib/chart/bar');
require('echarts/lib/component/tooltip');
require('echarts/lib/component/toolbox');
require('echarts/lib/component/legend');
require('echarts/lib/component/markLine');
require('echarts/lib/component/dataZoom');

export default {
  data () {
    return {
      field :[],
      percent :[],
      ipcmeaning : [],

    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    async drawLine(){
        /** 请求图表数据 */
        const { data } = await this.$axios.get("/testpie");
        this.field = data.testdata.name;
        this.percent = data.testdata.data;
        this.ipcmeaning = data.testdata.ipc;
        let percent = this.percent;
        let field = this.field;
        let ipcmeaning = this.ipcmeaning;
        // 基于准备好的dom，初始化echarts实例
        let Chart = echarts.init(document.getElementById('myChart5'));
        // 绘制图表
        Chart.setOption({
        tooltip: {
           trigger: 'item',
           confine: true,
           //formatter: "{a} <br/>{b}: {c} ({d}%)"
           formatter: function(params){
                          var ipcstr = params.data.flag;
                          var length = ipcstr.length;
                          var maxnumber = 20;
                          var maxrow = Math.ceil(length/maxnumber);
                          var newipc = '';
                          if(length> maxnumber){
                            for(var i=0; i<maxrow;i++){
                                var everyrow = '';
                                var start = i*maxnumber;
                                var end = start+ maxnumber;
                                if(i== maxrow-1){
                                    everyrow = ' '+ipcstr.substring(start)+' '
                                }else{
                                    everyrow = ' '+ipcstr.substring(start,end)+' '+"</br>"+' ';
                                }
                                newipc+=everyrow;
                            }
                          }else{
                            newipc = ' '+ipcstr+' ';
                          }
                          var str = params.seriesName+'<hr style="height:1px;border:none;border-top:1px solid #555555;"></hr>'+params.data.name +':' +params.data.value+'&nbsp;&nbsp;<span style="background-color:#334455;color: #eee;">'+ params.percent+'%</span><hr style="height:1px;border:none;border-top:1px solid #555555;"></hr>IPC:'+ newipc ;
                          return str;
                    },
                    backgroundColor: '#eee',
                    borderColor: '#aaa',
                    borderWidth: 1,
                    borderRadius: 4,
                    textStyle:{
                      color: '#334455',
                      lineHeight: 22,
                      align: 'center'
                    }
        },
        toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    saveAsImage : {show: true}
                },
                right : '15%',
                top:'5%',
            },
        series: [
        {
            name:'各领域专利百分比',
            type:'pie',
            radius: ['45%', '70%'],
            avoidLabelOverlap: true,
            label: {
                //normal:{show:false},
                emphasis: {
                    show:true,
                    //formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c|{c}}  {per|{d}%}  ',
                    /*formatter: function(params){
                          var ipcstr = params.data.flag;
                          var length = ipcstr.length;
                          var maxnumber = 20;
                          var maxrow = Math.ceil(length/maxnumber);
                          var newipc = '';
                          if(length> maxnumber){
                            for(var i=0; i<maxrow;i++){
                                var everyrow = '';
                                var start = i*maxnumber;
                                var end = start+ maxnumber;
                                if(i== maxrow-1){
                                    everyrow = ' '+ipcstr.substring(start)+' '
                                }else{
                                    everyrow = ' '+ipcstr.substring(start,end)+' '+"\n"+' ';
                                }
                                newipc+=everyrow;
                            }
                          }else{
                            newipc = ' '+ipcstr+' ';
                          }
                          var str = '{a|'+ params.seriesName+'}\n{hr|}\n{b|'+params.data.name +':}{c|' +params.data.value+'}  {per|'+ params.percent+'%}\n{hr|}\n{ipc| IPC:'+ newipc +'}';
                          return str;
                    },
                    backgroundColor: '#eee',
                    borderColor: '#aaa',
                    borderWidth: 1,
                    borderRadius: 4,
                    rich: {
                        a: {
                            color: '#334455',
                            lineHeight: 22,
                            align: 'center'
                        },
                        abg: {
                             backgroundColor: '#333',
                             width: '100%',
                             height: 0,
                             borderRadius: [4, 4, 0, 0]
                         },
                        hr: {
                            borderColor: '#aaa',
                            width: '100%',
                            borderWidth: 0.5,
                            height: 1
                        },
                        d: {
                          align:'center'
                        },
                        b: {
                            fontSize: 16,
                            lineHeight: 33,
                            color: '#334455',
                            align: 'center'
                        },
                        c: {
                            fontSize: 16,
                            lineHeight: 33,
                            color: '#334455',
                            align: 'center'
                        },
                        per: {
                            color: '#eee',
                            backgroundColor: '#334455',
                            padding: [2, 4],
                            borderRadius: 2,
                            align: 'center'
                        },
                        ipc: {
                            color: '#334455',
                            fontSize: 12,
                            lineHeight: 18,
                            align: 'center'
                        }
                    }*/
                }
            },
            labelLine: {
                normal: {
                    show: true,
                    length:20
                }
            },
            data:(function(){
             var res=[];
             for (var i=0;i<(percent.length);i++){
                res.push({value:percent[i],name:field[i],flag:ipcmeaning[i]});
             }
             return res;
             })(),//构造data，value：percent，name：field
             color:['#003366','#006699','#0099CC','#336699','#6699CC','#87CEEB','#B0E0E6','#4A708B','#7EC0EE','#B0E2FF','#4682B4'],
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