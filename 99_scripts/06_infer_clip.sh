set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
output_dir=01_Meta/04_clip_feature

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/dev/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Define Hyper-parameters


## 4. Run scripts
mkdir -p $output_dir
for i in $(cat $input_list);
do
    output=$output_dir/${i}
    mkdir -p $(dirname $output)
    CUDA_VISIBLE_DEVICES=0 $python $TOOL_DIR/infer/infer_clip.py \
        --input_ssf 00_Raw/$i \
        --output_features ${output}-0 \
	--rank 0 \
	--total_rank 2 &

    CUDA_VISIBLE_DEVICES=1 $python $TOOL_DIR/infer/infer_clip.py \
        --input_ssf 00_Raw/$i \
        --output_features ${output}-1 \
	--rank 1 \
	--total_rank 2 
    wait

    # for j in {0..1}; do
    #     CUDA_VISIBLE_DEVICES=0 $python $TOOL_DIR/infer/infer_clip.py \
    #         --input_ssf 00_Raw/$i \
    #         --output_features ${output}-${j}-4 &
    # done
    # for j in {2..3}; do
    #     CUDA_VISIBLE_DEVICES=1 $python $TOOL_DIR/infer/infer_clip.py \
    #         --input_ssf 00_Raw/$i \
    #         --output_features ${output}-${j}-4  &
    # done
    # wait 
done
