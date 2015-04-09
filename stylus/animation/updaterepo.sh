#/bin/sh

#Update from git repo

curdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pwd=`pwd`

tmpdir=/tmp/animate.css

cd /tmp

git clone https://github.com/daneden/animate.css.git

cd $tmpdir/source

for f in **/*.css ; do
	name=$(basename $f .css) 
	echo Parsing file: $name
	rm -f $curdir/$name.styl
	sed "/\.$name {/,/}/d" $f | stylus --css > $curdir/$name.styl	
done

rm -R -f $tmpdir