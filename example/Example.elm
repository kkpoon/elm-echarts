module Example exposing (..)

import Html exposing (Html, node)
import Html.Attributes exposing (attribute, style)
import ECharts exposing (ChartType(..), toJsonString)
import ECharts.PieChart exposing (defaultPieChartOption, defaultPieSeriesOption)
import ECharts.Style
    exposing
        ( defaultTitleOption
        , defaultTooltipOption
        , defaultLegendOption
        , defaultTextStyleOption
        )


pie : Html msg
pie =
    let
        title =
            { defaultTitleOption
                | text = Just "Website Traffic Sources"
                , subtext = Just "Demo Data"
                , left = Just "center"
            }

        tooltip =
            { defaultTooltipOption
                | formatter = Just "{a} <br/>{b} : {c} ({d}%)"
            }

        legend =
            { defaultLegendOption
                | orient = Just ECharts.Style.Vertical
                , left = Just "left"
                , data =
                    Just <|
                        List.map
                            (\name ->
                                { name = name
                                , icon = ""
                                , textStyle = defaultTextStyleOption
                                }
                            )
                            [ "Direct", "EDM", "WebAds", "VideoAds", "Search Engine" ]
            }

        series =
            { defaultPieSeriesOption
                | radius = Just ( "0", "55%" )
                , center = Just ( "50%", "60%" )
                , data =
                    Just
                        [ { value = 335, name = "Direct" }
                        , { value = 310, name = "EDM" }
                        , { value = 234, name = "WebAds" }
                        , { value = 135, name = "VideoAds" }
                        , { value = 1548, name = "Search Engine" }
                        ]
                , itemStyle =
                    Just
                        { emphasis =
                            Just
                                { shadowBlur = Just 10
                                , shadowOffsetX = Just 0
                                , shadowColor = Just "rgba(0, 0, 0, 0.5)"
                                }
                        }
            }

        pieChart =
            PieChart
                ({ defaultPieChartOption
                    | title = Just title
                    , tooltip = Just tooltip
                    , legend = Just legend
                    , series = Just [ series ]
                 }
                )

        chartOption =
            toJsonString pieChart
    in
        node "echarts-webcomponent"
            [ style [ ( "width", "600px" ), ( "height", "400px" ) ]
            , attribute "option" chartOption
            ]
            []
