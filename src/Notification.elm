module Notification
    exposing
        ( Permission(..)
        , getPermission
        , requestPermission
        , Notification
        , Options
        , defaultOptions
        , Error
        , create
        )

{-|
# Permission
@docs Permission, getPermission, requestPermission

# Notification
@docs Notification, Options, defaultOptions, create

# Error
@docs Error
-}

import Task exposing (Task)
import Native.Notification


-- Permission


{-| Permission status
    Default - The user hasn't been asked for permission yet, so notifications won't be displayed.
    Granted - The user has granted permission to display notifications, after having been asked previously.
    Denied - The user has explicitly declined permission to show notifications.
-}
type Permission
    = Default
    | Granted
    | Denied


{-| Get the current Notification permission
-}
getPermission : Task x Permission
getPermission =
    Native.Notification.getPermission


{-| Requesting permission
    Before an app can send a notification, the user must grant the application the right to do so.
-}
requestPermission : Task x Permission
requestPermission =
    Native.Notification.requestPermission



-- Notification


{-| Notification parameters.
    [More](https://developer.mozilla.org/en-US/docs/Web/API/Notification/Notification)
-}
type alias Notification =
    { title : String
    , options : Options
    }


{-| An options object containing any custom settings
    that you want to apply to the notification.
-}
type alias Options =
    { dir : String
    , lang : Maybe String
    , badge : Maybe String
    , body : Maybe String
    , tag : Maybe String
    , icon : Maybe String
    , image : Maybe String
    , vibrate : Maybe (List Int)
    , renotify : Bool
    }


{-| Default options

    options: Options
    options =
      { defaultOptions | body = Just("Notification text")}

    notificationData: Notification
    notificationData =
      { title = "Hello!", options = options}
-}
defaultOptions : Options
defaultOptions =
    { dir = "auto"
    , lang = Nothing
    , badge = Nothing
    , body = Nothing
    , tag = Nothing
    , icon = Nothing
    , image = Nothing
    , vibrate = Nothing
    , renotify = False
    }


{-| If you try to call notification, and permission is not Granted,
then you will see this error
-}
type Error
    = PermissionDenied
    | UserNotAsked


{-| Create a new Notification
-}
create : Notification -> Task Error ()
create =
    Native.Notification.spawnNotification
