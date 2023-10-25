set -xe

## 1. Define input and output
input_ssf=$1
output_img=$2
score_list=$3
threshold=$4

## 2. Define Environment
python=/mnt/lg107_ssd/zwshi/miniconda/envs/dev/bin/python
TOOL_DIR=/mnt/lg102/zwshi/projects/core/sbp/tools/

## 3. Run 
if [[ -z $score_list ]]; then
    $python $TOOL_DIR/ssf/make_snapshot.py \
        --input_ssf $input_ssf \
        --output_img $output_img \
        --max_height 320 \
	--shuffle 1
else
    awk -F "\t" -v t=$threshold '$NF > t {$(NF--)=""; print}' $score_list > ${output_img}.list  
    $python $TOOL_DIR/ssf/make_snapshot.py \
        --input_ssf $input_ssf \
        --output_img $output_img \
        --sublist ${output_img}.list \
        --shuffle 1 \
        --max_height 320        
fi
