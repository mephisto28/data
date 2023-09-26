set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
output_dir=01_Meta/03_clip_captions

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
    for r in {0..3};
    do
        CUDA_VISIBLE_DEVICES=0 $python $TOOL_DIR/infer/clip_interrogate.py \
	    --input_ssf 00_Raw/$i \
	    --output_prompts $output \
	    --rank $r \
	    --total_rank 8 &
    done
    for r in {4..7};
    do
        CUDA_VISIBLE_DEVICES=1 $python $TOOL_DIR/infer/clip_interrogate.py \
	    --input_ssf 00_Raw/$i \
	    --output_prompts $output \
	    --rank $r \
	    --total_rank 8 &
    done
    wait
done
