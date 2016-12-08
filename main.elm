module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String exposing (..)
import Material
import Material.Textfield as Textfield
import Material.Grid exposing (..)
import Material.Options as Options exposing (css)
import Material.Layout as Layout
import Material.Icon as Icon


main : Program Never Model Msg
main =
    Html.program { init = init, update = update, subscriptions = Material.subscriptions Mdl, view = view }



--Model


type alias Model =
    { userName : String
    , passWord : String
    , passWordAgain : String
    , mdl : Material.Model
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" "" "" Material.model, Cmd.none )



-- Update


type Msg
    = UpdateUser String
    | UpdatePassword String
    | UpdatePasswordAgain String
    | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateUser input ->
            ( { model | userName = input }, Cmd.none )

        UpdatePassword input ->
            ( { model | passWord = input }, Cmd.none )

        UpdatePasswordAgain input ->
            ( { model | passWordAgain = input }, Cmd.none )

        Mdl message ->
            Material.update message model



-- View


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        []
        { drawer = []
        , header = [ myheader ]
        , main = [ viewbody model ]
        , tabs = ( [], [] )
        }


boxed : List (Html.Attribute Msg)
boxed =
    [ style
        [ ( "margin", "auto" )
        , ( "width", "50%" )
        , ( "padding", "1%" )
        ]
    ]


viewbody : Model -> Html Msg
viewbody model =
    div
        boxed
        [ div
            boxed
            [ Textfield.render Mdl
                [ 0 ]
                model.mdl
                [ Textfield.label "User Name"
                , Textfield.floatingLabel
                , Textfield.onInput UpdateUser
                ]
            ]
        , passwordView model
        , passwordConfirmView model
        ]


passwordView : Model -> Html Msg
passwordView model =
    div
        boxed
        [ Textfield.render Mdl
            [ 1 ]
            model.mdl
            [ Textfield.label "Password"
            , Textfield.floatingLabel
            , Textfield.password
            , Textfield.onInput UpdatePassword
            ]
        ]


passwordConfirmView : Model -> Html Msg
passwordConfirmView model =
    div
        boxed
        [ Textfield.render Mdl
            [ 2 ]
            model.mdl
            [ Textfield.label "Confirm Password"
            , Textfield.floatingLabel
            , Textfield.password
            , Textfield.onInput UpdatePasswordAgain
            ]
        ]


myheader : Html Msg
myheader =
    div
        []
        [ h5
            [ style
                [ ( "margin-left", "8%" )
                , ( "margin-right", "8%" )
                , ( "float", "left" )
                , ( "display", "inline-block" )
                ]
            ]
            [ text "Ben Blog" ]
        , h5
            [ style
                [ ( "margin-left", "8%" )
                , ( "margin-right", "8%" )
                , ( "float", "right" )
                , ( "display", "inline-block" )
                ]
            ]
            [ a
                [ href "https://github.com/foxguy75"
                , style
                    [ ( "text-decoration", "none" )
                    , ( "color", "white" )
                    ]
                ]
                [ text "GitHub" ]
            ]
        ]
