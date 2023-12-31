set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
rank_count=${2:-"4"} 
output_dir=01_Meta/04_clip_feature

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/dev/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Define Hyper-parameters


## 4. Run scripts
function cleanup() {
    echo "Interrupt signal received. Terminating subprocesses..."
    pkill -P $$  # Terminate all child processes
}

trap cleanup INT

mkdir -p $output_dir
for i in $(cat $input_list);
do
    output=$output_dir/${i}
    mkdir -p $(dirname $output)
    
    for rank in $(seq 0 $((rank_count - 1)));
    do
	CUDA_VISIBLE_DEVICES=$(( $rank % 2 )) $python $TOOL_DIR/infer/infer_clip.py \
            --input_ssf 00_Raw/$i \
            --output_features ${output}-$rank \
            --rank $rank \
            --total_rank $rank_count &
    done

    wait
done
