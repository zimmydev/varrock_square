module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, h2, h3, h4, h5, h6, header, img, main_, p, span, text)
import Html.Attributes exposing (alt, class, id, src)



---- MODEL ----


type alias Flags =
    { dimensions : ( Int, Int )
    , images : ImageAssets
    }


type alias ImageAssets =
    { background : String
    , contentBackground : String
    , banner : String
    , logo : String
    , notFound : String
    }


type alias Model =
    { dimensions : ( Int, Int )
    , images : ImageAssets
    }


init : Flags -> ( Model, Cmd Msg )
init { dimensions, images } =
    -- TODO Import the cache
    ( { dimensions = dimensions, images = images }
        |> Debug.log "Initialized elm app with flags"
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ id "elm-app" ]
        [ header []
            [ div [ id "logo" ]
                [ img [ src model.images.logo, alt "The Varrock Square logo" ] []
                , span [] [ text "Varrock Square" ]
                ]
            ]
        , main_ []
            [ h1 [] [ text "1. Welcome to the app." ]
            , h2 [] [ text "2. Welcome to the app." ]
            , h3 [] [ text "3. Welcome to the app." ]
            , h4 [] [ text "4. Welcome to the app." ]
            , h5 [] [ text "5. Welcome to the app." ]
            , h6 [] [ text "6. Welcome to the app." ]
            , p [] [ text "Elm is working!" ]
            , div [ class "spinner" ] (List.repeat 4 (div [] []))
            ]
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }



---- PORTS ----
-- port cacheChanged : (Maybe Value -> msg) -> Sub msg
-- port storeCache : Maybe Value -> Cmd msg
