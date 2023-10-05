Saltstack configuration via state files

on top of two nginx webserver, haproxy lb is running and being monitered by prometheus also at the mean time if there is any config changes detected on git via salt it will pull those changes and got mergered during the next highstate.
