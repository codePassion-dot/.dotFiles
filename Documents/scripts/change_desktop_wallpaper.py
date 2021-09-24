import os
import time
from random import seed
from random import randint
seed(1)
BACKGROUNDS = os.getenv('BACKGROUNDS')
desktop_wallpapers_path = BACKGROUNDS + '/wallpapers/'
images_folder = os.listdir(desktop_wallpapers_path)
shell_program_command = 'feh --bg-scale'
while True:
    random_wallpaper_screen1 = randint(0,len(images_folder))
    random_wallpaper_screen2 = randint(0,len(images_folder))
    command_to_change_wallpaper = shell_program_command + ' ' + desktop_wallpapers_path + images_folder[random_wallpaper_screen1] + ' ' + desktop_wallpapers_path + images_folder[random_wallpaper_screen2]
    os.system(command_to_change_wallpaper)
    time.sleep(300)
