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
    $python $TOOL_DIR/image/crop_body_with_meta.py \
        --input_raw_ssf 00_Raw/$i \
        --input_face_meta 01_Meta/00_face/$i \
        --input_body_meta 01_Meta/01_body/$i \
        --input_text_meta 01_Meta/02_ocr/$i \
        --output_face_meta 03_Processed/00_cropbody4/$i \
        --output_crop_dir 03_Processed/00_cropbody4/images/ \
        --basename_level 5 \
	    --exclude_list 02_Filter/exclude.list
done
