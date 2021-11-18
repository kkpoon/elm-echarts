module ECharts.BarChart exposing
    ( BarChartOption
    , defaultBarChartOption
    , BarSeriesOption
    , defaultBarSeriesOption
    , encodeBarChartOption
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

import ECharts.Style exposing (..)
import Helpers
    exposing
        ( toBoolValueList
        , toFloatValueList
        , toIntValueList
        , toStringValueList
        , toValueList
        )
import Json.Encode
    exposing
        ( Value
        , bool
        , float
        , int
        , list
        , object
        , string
        )


{-| describe the chart option of Bar chart
-}
type alias BarChartOption =
    { title : Maybe TitleOption
    , color : Maybe (List String)
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
    , color = Nothing
    , tooltip = Nothing
    , legend = Nothing
    , xAxis = Nothing
    , yAxis = Nothing
    , series = Nothing
    }


{-| describe the [data series](https://ecomfe.github.io/echarts-doc/public/en/option.html#series-Bar) of Bar chart
-}
type alias Normal =
    { color : Maybe String
    }


type alias ItemStyle =
    { normal : Normal
    }


type alias BarSeriesOption =
    { name : Maybe String
    , barGap : Maybe Int
    , data :
        Maybe
            (List
                { value : Float
                , itemStyle : Maybe ItemStyle
                }
            )
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

        encodeColorsList color =
            list <| List.map (\d -> string d) color
    in
    object <|
        List.concat
            [ toValueList encodeTitleOption "title" option.title
            , toValueList encodeColorsList "color" option.color
            , toValueList encodeTooltipOption "tooltip" option.tooltip
            , toValueList encodeLegendOption "legend" option.legend
            , toValueList encodeXAxisOption "xAxis" option.xAxis
            , toValueList encodeYAxisOption "yAxis" option.yAxis
            , toValueList encodeSeriesList "series" option.series
            ]


encodeNormalOption : Normal -> Value
encodeNormalOption option =
    object <| List.concat [ toStringValueList "color" option.color ]


encodeItemStyleOption : ItemStyle -> Value
encodeItemStyleOption option =
    object [ ( "normal", encodeNormalOption option.normal ) ]


encodeBarSeriesOption : BarSeriesOption -> Value
encodeBarSeriesOption option =
    let
        dataEncoder data =
            list <|
                List.map
                    (\d ->
                        object <|
                            List.concat
                                [ [ ( "value", float d.value ) ]
                                , toValueList encodeItemStyleOption "itemStyle" d.itemStyle
                                ]
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
