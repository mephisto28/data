set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
output_dir=03_Processed/00_cropbody/

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/dev/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Define Hyper-parameters


## 4. Run scripts
mkdir -p $output_dir
for i in $(cat $input_list);
do
    mkdir -p $output_dir/$(basename $i)
    $python $TOOL_DIR/ssf/unpack.py \
        --input_ssf 00_Raw/$i \
        --output_dir $output_dir/$(basename $i)
done
