module ECharts.PieChart
    exposing
        ( PieChartOption
        , PieSeriesOption
        , encodePieChartOption
        , defaultPieChartOption
        , defaultPieSeriesOption
        )

{-| Pie Chart Options

This module helps to create Pie Chart Option.

ECharts official [examples](https://ecomfe.github.io/echarts-examples/public/index.html#chart-type-pie)


# Definitions

@docs PieChartOption

@docs defaultPieChartOption

@docs PieSeriesOption

@docs defaultPieSeriesOption


# Encoders

@docs encodePieChartOption

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


{-| describe the chart option of pie chart
-}
type alias PieChartOption =
    { title : Maybe TitleOption
    , tooltip : Maybe TooltipOption
    , legend : Maybe LegendOption
    , series : Maybe (List PieSeriesOption)
    }


{-| create a pie chart option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultPieChartOption : PieChartOption
defaultPieChartOption =
    { title = Nothing, tooltip = Nothing, legend = Nothing, series = Nothing }


{-| describe the [data series](https://ecomfe.github.io/echarts-doc/public/en/option.html#series-pie) of pie chart
-}
type alias PieSeriesOption =
    { name : Maybe String
    , legendHoverLink : Maybe Bool
    , hoverAnimation : Maybe Bool
    , selectedMode : Maybe SelectedMode
    , selectedOffset : Maybe Int
    , clockwise : Maybe Bool
    , startAngle : Maybe Float
    , minAngle : Maybe Float
    , roseType : Maybe Bool
    , avoidLabelOverlap : Maybe Bool
    , stillShowZeroSum : Maybe Bool
    , radius : Maybe ( String, String )
    , center : Maybe ( String, String )
    , itemStyle :
        Maybe
            { emphasis :
                Maybe
                    { shadowBlur : Maybe Int
                    , shadowOffsetX : Maybe Int
                    , shadowColor : Maybe String
                    }
            }
    , data : Maybe (List { value : Float, name : String })
    }


{-| create a pie chart series option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultPieSeriesOption : PieSeriesOption
defaultPieSeriesOption =
    { name = Nothing
    , legendHoverLink = Nothing
    , hoverAnimation = Nothing
    , selectedMode = Nothing
    , selectedOffset = Nothing
    , clockwise = Nothing
    , startAngle = Nothing
    , minAngle = Nothing
    , roseType = Nothing
    , avoidLabelOverlap = Nothing
    , stillShowZeroSum = Nothing
    , radius = Nothing
    , center = Nothing
    , itemStyle = Nothing
    , data = Nothing
    }



-- encoder


{-| encode the pie chart option to Json.Encode.Value
-}
encodePieChartOption : PieChartOption -> Value
encodePieChartOption option =
    let
        encodeSeriesList =
            list encodePieSeriesOption
    in
        object <|
            List.concat
                [ toValueList encodeTitleOption "title" option.title
                , toValueList encodeTooltipOption "tooltip" option.tooltip
                , toValueList encodeLegendOption "legend" option.legend
                , toValueList encodeSeriesList "series" option.series
                ]


encodePieSeriesOption : PieSeriesOption -> Value
encodePieSeriesOption option =
    let
        tupleEncoder t =
            list string [ Tuple.first t, Tuple.second t ]

        emphasisEncoder data =
            object <|
                List.concat
                    [ toIntValueList "shadowBlur" data.shadowBlur
                    , toIntValueList "shadowOffsetX" data.shadowOffsetX
                    , toStringValueList "shadowColor" data.shadowColor
                    ]

        itemStyleEncoder data =
            object <|
                List.concat
                    [ toValueList emphasisEncoder "emphasis" data.emphasis
                    ]

        dataEncoder =
            list
                (\d ->
                    object
                        [ ( "name", string d.name )
                        , ( "value", float d.value )
                        ]
                )
    in
        object <|
            List.concat
                [ [ ( "type", string "pie" ) ]
                , toStringValueList "name" option.name
                , toBoolValueList "legendHoverLink" option.legendHoverLink
                , toBoolValueList "hoverAnimation" option.hoverAnimation
                , toValueList encodeSelectedModeValue "selectedMode" option.selectedMode
                , toIntValueList "selectedOffset" option.selectedOffset
                , toBoolValueList "clockwise" option.clockwise
                , toFloatValueList "startAngle" option.startAngle
                , toFloatValueList "minAngle" option.minAngle
                , toBoolValueList "roseType" option.roseType
                , toBoolValueList "avoidLabelOverlap" option.avoidLabelOverlap
                , toBoolValueList "stillShowZeroSum" option.stillShowZeroSum
                , toValueList tupleEncoder "radius" option.radius
                , toValueList tupleEncoder "center" option.center
                , toValueList itemStyleEncoder "itemStyle" option.itemStyle
                , toValueList dataEncoder "data" option.data
                ]
