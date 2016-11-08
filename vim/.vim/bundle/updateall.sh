home=$PWD
for path in `find . -maxdepth 1 -type d`
do
	cd $path
	git pull
	git submodule update
	cd $home
done
