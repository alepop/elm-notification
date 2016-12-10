module Notification
    exposing
        ( Permission(..)
        , getPermission
        , requestPermission
        , Notification
        , Options
        , Error
        , create
        )

{-|
# Permission
@docs Permission, getPermission, requestPermission

# Notification
@docs Notification, Options, Error, create
-}

import Native.Notification
import Task exposing (Task)


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
    { body : String
    , icon : String
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
