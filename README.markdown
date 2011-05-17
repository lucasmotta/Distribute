Distribute is an ActionScript class where you can distribute Display Objects along a path.
You can distribute using the default paths, like **rectangle**, **triangle**, **polygon**, **circle** and **star**.
Or you can create your own path very easily.

To distribute your children, do this:
`Distribute.rectangle(items : Array, width : int, height : int, align : String = DistributeAlign.TOP_LEFT);`

You can orient your objects to the path like this:
`Distribute.rectangle(items, 400, 200).orientToPath();`

Feel free to use whatever you want.