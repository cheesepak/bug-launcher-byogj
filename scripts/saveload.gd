extends Node
#following https://youtu.be/mI4HfyBdV-k

#setup
const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
#arbitrary key, should be elsewhere
const SECURITY_KEY = "abg4gykjqAOgui3cG7&U#YTKDEU"

#make a new player_data structure
var player_data = PlayerData.new()



#when ready make save dir if it does not exist
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func _ready():
	verify_save_directory(SAVE_DIR)


#do the save
func save_data(path: String):
	#open and decrypt the file
	var file = FileAccess.open_encrypted_with_pass(
		path, 
		FileAccess.WRITE, 
		SECURITY_KEY
	)
	#handle nonexistant file
	if file == null:
		#print the error
		print(FileAccess.get_open_error())
		#bail!!
		return
	
	#build the data dictionary with stuff we need to save
	#here we ideally we want to iterate through saveable objects and get their data
	#but for now...
	var data = {
		"test" = player_data.test,
	}
	
	#stringify it with Tab separator
	var json_string = JSON.stringify(data, "\t")
	#put it in the file
	file.store_string(json_string)
	#and close it!
	file.close()
	
	#end save_data()--------------------------------------------

#load json data into PlayerData structure
func load_data(path: String):
	#make sure we have a file
	if FileAccess.file_exists(path):
		#open and decrypt the file
		var file = FileAccess.open_encrypted_with_pass(
			path, 
			FileAccess.READ,
			SECURITY_KEY
		)
		#doublecheck we really have a file i guess lol
		if file == null:
			#print and bail!
			print(FileAccess.get_open_error())
			return
			
		#get the string from the file
		var file_contents = file.get_as_text()
		#and close it!
		file.close()
		
		#parse the string
		var data = JSON.parse_string(file_contents)
		#if parsing failed
		if data == null:
			#that's an error
			printerr("Could not parse %s as a json string: (%s)" % [path, file_contents])
			#bail!!
			return
		
		#reset player_data to blank slate
		player_data = PlayerData.new()
		#assign the data out
		player_data.test = data.test
		
	else:#no file?
		#soulja boy tellem
		printerr("Cannot open non-existant file at %s!" % [path])
