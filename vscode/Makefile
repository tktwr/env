VSCODE=$(SYS_WIN_HOME)/AppData/Roaming/Code/User

vimdiff:
	vimdiff settings.json $(VSCODE)/settings.json
	vimdiff keybindings.json $(VSCODE)/keybindings.json

push:
	cp settings.json $(VSCODE)
	cp keybindings.json $(VSCODE)

pull:
	cp $(VSCODE)/settings.json .
	cp $(VSCODE)/keybindings.json .

