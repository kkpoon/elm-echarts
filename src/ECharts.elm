module ECharts exposing (EChartsConfig(..), echarts, toJsonString)

{-| This is a [ECharts](http://echarts.baidu.com/) chart option types
collection and a helper to use
[ECharts WebComponent](https://github.com/kkpoon/echarts-webcomponent).


## Why Web Component?

Please watch [this](https://www.youtube.com/watch?v=ar3TakwE8o0&t=1s)
video about Elm and Web Components by Richard Feldman


# Create

@docs echarts


# Definitions

@docs EChartsConfig


# Helpers

@docs toJsonString

-}

import Html exposing (Html, node)
import Html.Attributes exposing (attribute, style)
import Json.Encode exposing (encode)
import ECharts.PieChart exposing (PieChartOption, encodePieChartOption)
import ECharts.BarChart exposing (BarChartOption, encodeBarChartOption)


{-| create echarts DOM node
-}
echarts : EChartsConfig -> Html msg
echarts config =
    node "echarts-webcomponent" [ attribute "option" (toJsonString config) ] []


{-| the chart type
-}
type EChartsConfig
    = PieChart PieChartOption
    | BarChart BarChartOption


{-| convert the chart option to a string of json, which could apply to the
[echarts-webcomponent](https://github.com/kkpoon/echarts-webcomponent) `option`
attribute
-}
toJsonString : EChartsConfig -> String
toJsonString chart =
    encode 0 <|
        case chart of
            PieChart option ->
                encodePieChartOption option

            BarChart option ->
                encodeBarChartOption option
