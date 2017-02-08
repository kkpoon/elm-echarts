module ECharts exposing (ChartType(..), toJsonString)

{-| This is a [ECharts](http://echarts.baidu.com/) chart option types
collection and a helper to use
[ECharts WebComponent](https://github.com/kkpoon/echarts-webcomponent).

## Why Web Component?

Please watch [this](https://www.youtube.com/watch?v=ar3TakwE8o0&t=1s)
video about Elm and Web Components by Richard Feldman

# Definitions

@docs ChartType

# Helpers

@docs toJsonString

-}

import Json.Encode exposing (encode)
import ECharts.PieChart exposing (PieChartOption, encodePieChartOption)


{-| the chart type
-}
type ChartType
    = PieChart PieChartOption


{-| convert the chart option to a string of json, which could apply to the
[echarts-webcomponent](https://github.com/kkpoon/echarts-webcomponent) `option`
attribute
-}
toJsonString : ChartType -> String
toJsonString chart =
    encode 0 <|
        case chart of
            PieChart option ->
                encodePieChartOption option
