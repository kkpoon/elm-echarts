# elm-echarts

This is a [EChart](http://echarts.baidu.com/) chart option types
collection and a helper to use
[EChart WebComponent](https://github.com/kkpoon/echarts-webcomponent).

In ECharts tutorial, the following code in `JavaScript`

```js
var myChart = echarts.init(document.getElementById('main'));

var option = option = {
    title : {
        text: '某站点用户访问来源',
        subtext: '纯属虚构',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
    },
    series : [
        {
            name: '访问来源',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:335, name:'直接访问'},
                {value:310, name:'邮件营销'},
                {value:234, name:'联盟广告'},
                {value:135, name:'视频广告'},
                {value:1548, name:'搜索引擎'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
}

myChart.setOption(option);
```

could be represent in `Elm` as

```elm
let
    data =
        [
            {value=335, name="直接访问"},
            {value=310, name="邮件营销"},
            {value=234, name="联盟广告"},
            {value=135, name="视频广告"},
            {value=1548, name="搜索引擎"}
        ]

    legend =
        List.map .name data

    dataSeries =
        { name = ""
        , radius = ( "0", "60%" )
        , center = ( "50%", "50%" )
        , data = data
        , itemStyle =
            { emphasis =
                { shadowBlur = 10
                , shadowOffsetX = 0
                , shadowColor = "rgba(0, 0, 0, 0.5)"
                }
            }
        }

    chartOption =
        ECharts.toJsonString
            (ECharts.PieChart
                { title =
                    { show = False
                    , text = ""
                    , subtext = ""
                    , left = "center"
                    }
                , tooltip =
                    { show = True
                    , formatter = "{d}%"
                    }
                , legend =
                    { show = False
                    , orient = ECharts.Vertical
                    , left = "left"
                    , data = legend
                    }
                , series = [ dataSeries ]
                }
            )
in
    node "echarts-webcomponent"
        [ style [ ( "width", "400px" ), ( "height", "300px" ) ]
        , attribute "option" chartOption
        ]
        []
```

## Setup

Install the webcomponent and the dependencies from [bower](https://bower.io/)

```shell
bower install --save echarts-webcomponent
```

Add the following to your `.html` file

```html
<html>
  <head>
    <!-- your other header tags -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script src="bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
    <script src="bower_components/custom-elements/custom-elements.min.js"></script>
    <script src="bower_components/echarts/dist/echarts.min.js"></script>
    <link rel="import" href="bower_components/echarts-webcomponent/echarts-webcomponent.html" />
    <!-- your other header tags -->
  </head>
  <body>
    <!-- your body -->
  </body>
</html>
```

Install `elm-echarts`

```shell
elm package install elm-echarts
```