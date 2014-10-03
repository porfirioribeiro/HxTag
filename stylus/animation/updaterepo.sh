#/bin/sh

#Update from git repo

curdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pwd=`pwd`

tmpdir=/tmp/animate.css

cd /tmp

git clone https://github.com/daneden/animate.css.git

cd $tmpdir/source

mkdir all

mv -f */*.css all 

cd all

for f in *.css; do 
	name=${f%.css}
	echo Parsing file: $name
	rm -f $curdir/$name.styl
	sed "/\.$name {/,/}/d" $name.css > $curdir/$name.styl
done

rm -R -f $tmpdir