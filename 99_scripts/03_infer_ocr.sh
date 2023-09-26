set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
output_dir=01_Meta/02_ocr

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/paddle/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Define Hyper-parameters


## 4. Run scripts
mkdir -p $output_dir
for i in $(cat $input_list);
do
    output=$output_dir/$i
    mkdir -p $(dirname $output)
    $python $TOOL_DIR/infer/infer_ocr.py \
	    --input_ssf 00_Raw/$i \
	    --output_ssf $output
done
