#!/bin/sh

set -e
set -u
set -x
#TODO: script the installation of the pre-reqs: sqlite3
#sudo apt-get install sqlite3 libsqlite3-dev libsqlite3-ruby

outdir='build_artefacts'
rm -rf $outdir
mkdir -p $outdir

echo "started build script $0 in `$outdir` at `date`"

show_platform.sh > $outdir/platform.txt 2>&1 || true

echo "Running custom build.sh - install bundle, rake"
bundle --path=.gem/
set +e
bundle exec rake rcov > $outdir/testtask.log
spec_rc=$?
set -e

exit $spec_rc
