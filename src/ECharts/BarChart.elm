module ECharts.BarChart
    exposing
        ( BarChartOption
        , BarSeriesOption
        , encodeBarChartOption
        , defaultBarChartOption
        , defaultBarSeriesOption
        )

{-| Bar Chart Options

This module helps to create Bar Chart Option.

ECharts official [examples](https://ecomfe.github.io/echarts-examples/public/index.html#chart-type-Bar)


# Definitions

@docs BarChartOption

@docs defaultBarChartOption

@docs BarSeriesOption

@docs defaultBarSeriesOption


# Encoders

@docs encodeBarChartOption

-}

import Json.Encode
    exposing
        ( Value
        , object
        , string
        , bool
        , int
        , float
        , list
        )
import Helpers
    exposing
        ( toValueList
        , toStringValueList
        , toFloatValueList
        , toIntValueList
        , toBoolValueList
        )
import ECharts.Style exposing (..)


{-| describe the chart option of Bar chart
-}
type alias BarChartOption =
    { title : Maybe TitleOption
    , tooltip : Maybe TooltipOption
    , legend : Maybe LegendOption
    , xAxis : Maybe XAxisOption
    , yAxis : Maybe YAxisOption
    , series : Maybe (List BarSeriesOption)
    }


{-| create a Bar chart option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultBarChartOption : BarChartOption
defaultBarChartOption =
    { title = Nothing
    , tooltip = Nothing
    , legend = Nothing
    , xAxis = Nothing
    , yAxis = Nothing
    , series = Nothing
    }


{-| describe the [data series](https://ecomfe.github.io/echarts-doc/public/en/option.html#series-Bar) of Bar chart
-}
type alias BarSeriesOption =
    { name : Maybe String
    , barGap : Maybe Int
    , data : Maybe (List { value : Float })
    }


{-| create a Bar chart series option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultBarSeriesOption : BarSeriesOption
defaultBarSeriesOption =
    { name = Nothing
    , barGap = Nothing
    , data = Nothing
    }



-- encoder


{-| encode the Bar chart option to Json.Encode.Value
-}
encodeBarChartOption : BarChartOption -> Value
encodeBarChartOption option =
    let
        encodeSeriesList series =
            list <| List.map encodeBarSeriesOption series
    in
        object <|
            List.concat
                [ toValueList encodeTitleOption "title" option.title
                , toValueList encodeTooltipOption "tooltip" option.tooltip
                , toValueList encodeLegendOption "legend" option.legend
                , toValueList encodeXAxisOption "xAxis" option.xAxis
                , toValueList encodeYAxisOption "yAxis" option.yAxis
                , toValueList encodeSeriesList "series" option.series
                ]


encodeBarSeriesOption : BarSeriesOption -> Value
encodeBarSeriesOption option =
    let
        dataEncoder data =
            list <|
                List.map
                    (\d ->
                        object
                            [ ( "value", float d.value ) ]
                    )
                    data
    in
        object <|
            List.concat
                [ [ ( "type", string "bar" ) ]
                , toStringValueList "name" option.name
                , toIntValueList "barGap" option.barGap
                , toValueList dataEncoder "data" option.data
                ]
