set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
anno=${2:-canny}
output_dir=01_Meta/05_controlnet/$anno

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/dev/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Define Hyper-parameters


## 4. Run scripts
mkdir -p $output_dir
for i in $(cat $input_list);
do
    output=$output_dir/$i
    mkdir -p $(dirname $output)
    CUDA_VISIBLE_DEVICES=0 $python $TOOL_DIR/infer/infer_controlaux.py \
	    --input_ssf 00_Raw/$i \
	    --output_ssf $output_dir/${i} \
	    --anno $anno \
		--infer_mode cpu
done
