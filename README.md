# tank-bots

[MAIN INFO HERE](https://itch.io/jam/tank-bots-charity-tournament)

the game is made in [godot 4](https://godotengine.org/), you should have it downloaded in order to make your bot

`git clone` this project, or download it as a zip (big green 'Code' button above the files > 'Download ZIP')

---

once youve opened the project in godot:
- go to scenes > sample tanks
- duplicate the `SampleTank` folder
- rename the folder and files within it
- rename the `SampleTank` node to your own tank name (this will be shown ingame)
- assign your script to the `PlayerScript` node (otherwise it will be using `SampleTank.gd`, which doesnt do anything)
- get to scripting :3 use the docs linked below
- when done, go to the `Map.tscn` scene (in the `scenes` folder), and place your tank scene under either the `Tank1` or `Tank2` node
- you can use one of the other sample tanks to test your tank on

controls:
- spacebar to play/pause the game
- left arrow to slow down
- right arrow to speed up

---

[DOCUMENTATION](documentation.md)
