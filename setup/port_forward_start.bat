netsh interface portproxy add v4tov4 listenport=8888 listenaddress=127.0.0.1 connectport=8080 connectaddress=proxy.example.com
sc config iphlpsvc start=auto
sc start iphlpsvc
