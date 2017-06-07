module Simple exposing (main)

import Html exposing (Html, button, div, h1, text)
import Html.Events exposing (onClick)
import Json.Decode exposing (Value)
import Task
import Notification exposing (Error, Notification, Permission, create, defaultOptions, requestPermission)


type Msg
    = SpawnInfo
    | NotificationResult (Result Error ())
    | RequestPermissionResult Permission


type alias Model =
    ()


init : ( Model, Cmd Msg )
init =
    ( (), Task.perform RequestPermissionResult requestPermission )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpawnInfo ->
            let
                cmd =
                    Notification "Here is you info!" { defaultOptions | body = Just ("Notification text") }
                        |> create
                        |> Task.attempt NotificationResult
            in
                ( model, cmd )

        NotificationResult (Err error) ->
            let
                _ =
                    Debug.log "Error" (toString error)
            in
                model ! []

        NotificationResult (Ok _) ->
            model ! []

        RequestPermissionResult permission ->
            let
                _ =
                    Debug.log "permission" (toString permission)
            in
                model ! []


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Simple notification example" ]
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
