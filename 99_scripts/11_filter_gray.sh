set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
output_dir=02_Filter/00_color

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/dev/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Define Hyper-parameters


## 4. Run scripts
mkdir -p $output_dir
for i in $(cat $input_list);
do
    output=$output_dir/${i}.list
    mkdir -p $(dirname $output)
    if [ ! -f $output ]; then
        $python $TOOL_DIR/image/filter_gray.py \
            --input_ssf 00_Raw/$i \
            --output_list $output 
    fi
    bash 99_scripts/99_show_samples.sh \
        00_Raw/$i \
        $(echo $output | sed 's@.list@_filter.995.jpg@') \
        $output \
        0.995
    bash 99_scripts/99_show_samples.sh \
        00_Raw/$i \
        $(echo $output | sed 's@.list@_filter.99.jpg@') \
        $output \
        0.99 
    bash 99_scripts/99_show_samples.sh \
        00_Raw/$i \
        $(echo $output | sed 's@.list@_filter.97.jpg@') \
        $output \
        0.97
done
