rem powercfg /s 6781f8b6-d310-490a-941d-85800813dc7b
netsh interface set interface "Wi-Fi" admin=enable
timeout /t 10
ping youtube.com
