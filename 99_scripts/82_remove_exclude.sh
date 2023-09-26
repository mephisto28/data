cat 02_Filter/exclude.list | \
	sed 's@/mnt/lg104/character_dataset/rawdataset/@@' | \
	sed 's@/mnt/lg106/character_dataset/rawdataset/@@' | \
	awk '{print "03_Processed/00_cropbody4/images/body/"$0}' | \
	xargs rm

cat 02_Filter/exclude.list | \
	sed 's@/mnt/lg104/character_dataset/rawdataset/@@' | \
	sed 's@/mnt/lg106/character_dataset/rawdataset/@@' | \
	awk '{print "03_Processed/00_cropbody4/images/face/"$0}' | \
	xargs rm
