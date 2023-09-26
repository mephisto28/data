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
    $python $TOOL_DIR/convert/add_hw.py \
        --input_ssf 03_Processed/00_cropbody/$i \
        --input_raw_ssf 00_Raw/$i \
        --output_ssf 03_Processed/00_cropbody/result.list 
done
