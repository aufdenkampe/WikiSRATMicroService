import os
import zipfile
from shutil import copyfile
from shutil import rmtree

def zipdir(path, ziph):
    # ziph is zipfile handle
    for root, dirs, files in os.walk(path):
        for file in files:
            ziph.write(os.path.join(root, file),os.path.join(root, file).replace("deploy/",""))

zip_ref = zipfile.ZipFile("dependencies.zip", 'r')
zip_ref.extractall("deploy")
zip_ref.close()

copyfile("constants.py","deploy/constants.py")
copyfile("DatabaseAdapter.py","deploy/DatabaseAdapter.py")
copyfile("StringParser.py","deploy/StringParser.py")
copyfile("main.py","deploy/main.py")

zip_out = zipfile.ZipFile("SRAT.zip", 'w')
zipdir('deploy/', zip_out)
zip_out.close()

rmtree("deploy/")

