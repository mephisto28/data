set -xe

## 1. Define input and output
input_list=${1:-"00_Raw/input.list"}
rank_count=${2:-"2"} 
output_dir=01_Meta/06_dwpose

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

    for ((rank=0; rank < rank_count; rank++));
    do
        CUDA_VISIBLE_DEVICES=$rank $python $TOOL_DIR/infer/infer_dwpose.py \
            --input_ssf 00_Raw/$i \
            --output_ssf ${output}-$rank \
            --rank $rank \
            --total_rank $rank_count &
    done

    wait
done
