#!/bin/sh
#
# test styles via css.

dir=$(dirname $0)
svg=$1
test -z "$svg" && svg="$dir/corel_style_css.svg"

export PYTHONPATH=/usr/share/inkscape/extensions/

rm -f /tmp/thunderlaser.json
(set -x; python $dir/../thunderlaser.py --cut_color=red --cut_group=cut_wood --cut_wood=30,7,18 --mark_color=green --smoothness=0.2 --freq1=20 --maxwidth=900 --maxheight=600 --bbox_only=false --dummy=true $svg)
echo -n "red path found:   "
jq .cut.paths /tmp/thunderlaser.json | wc
echo "expected:              24      24     215"
echo -n "green path found: "
jq .mark.paths /tmp/thunderlaser.json | wc
echo "expected:             392     392    6046"

