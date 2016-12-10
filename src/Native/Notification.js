var _alepop$elm_notification$Native_Notification = function() {

    var Task = _elm_lang$core$Native_Scheduler;

    var status = {
        Denied: "denied",
        Granted: "granted",
        Default: "default"
    }

    function permission() {
        switch (Notification.permission){
        case status.Denied:
            return {ctor: "Denied"}
        case status.Granted:
            return {ctor: "Granted"}
        default:
            return {ctor: "Default"}

        }
    }

    return {
        getPermission: Task.nativeBinding(function(callback) {
	        callback(Task.succeed(permission(Notification.permission)));
        }),
        requestPermission: Task.nativeBinding(function(callback) {
            Notification.requestPermission(function(result) {
                callback(Task.succeed(permission(result)));
           })
        }),
        spawnNotification: function(data) {
            return Task.nativeBinding(function(callback) {
                switch (Notification.permission) {
                    case status.Granted:
                        console.warn(data);
                        new Notification(data.title, data.options);
                        return callback(Task.succeed(_elm_lang$core$Native_Utils.Tuple0));
                    case status.Denied:
                        return callback(Task.fail({ctor: "PermissionDenied"}))
                    case status.Default:
                        return callback(Task.fail({ctor: "UserNotAsked"}))

                }
            })
        }
    }
}();
