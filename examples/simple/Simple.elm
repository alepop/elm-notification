module Simple exposing (main)

import Html exposing (Html, button, div, h1, text)
import Html.Events exposing (onClick)
import Json.Decode exposing (Value)
import Task exposing (Task, perform, attempt)
import Notification exposing (Error, Notification, Permission, create, defaultOptions, requestPermission)


type Msg
    = SpawnInfo
    | NotificationResult (Result Error ())
    | RequestPermissionResult Permission


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Asking for notification permission...", perform RequestPermissionResult requestPermission )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpawnInfo ->
            let
                cmd =
                    Notification "Here is you info!" { defaultOptions | body = Just ("Notification text") }
                        |> create
                        |> attempt NotificationResult
            in
                ( model, cmd )

        NotificationResult (Err error) ->
            ("Notification failed " ++ (toString error)) ! []

        NotificationResult (Ok _) ->
            ("Notification success!") ! []

        RequestPermissionResult permission ->
            ("Permission result: " ++ (toString permission)) ! []


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Simple notification example" ]
        , div [] [ text ("Debug information: " ++ model) ]
        , button [ onClick SpawnInfo ] [ text "Spawn info" ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
