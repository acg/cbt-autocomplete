HOST?=127.0.0.1
PORT?=3456
DATAURL=https://huggingface.co/datasets/amazon/AmazonQAC/resolve/main/train
DATASET=1d4931ef-16a0-4dc1-8034-ddaa3f7ddec6-c000

default : deps serve

deps :
	@ for prog in cbt tcpserver duckdb curl; do which -s $$prog || { echo "Please install: $$prog" 1>&2 && exit 9 ; }; done

serve : autocomplete.dump
	@ echo 'Try it out at: http://$(HOST):$(PORT)/' 1>&2
	tcpserver $(HOST) $(PORT) ./httpd

autocomplete.dump : autocomplete.txt
	{ sed -e 's/^/add /' $< ; echo dump $@ ; } | cbt >/dev/null

autocomplete.txt : datafiles.list
	sed -e 's/parquet/txt/' $< | xargs make -C .
	sed -e 's/parquet/txt/' $< | xargs cat > $@

datafiles.list :
	for i in 0 1 2 3; do printf 'part-%05d-%s.snappy.parquet\n' $$i "$(DATASET)"; done > $@

%.snappy.txt : %.snappy.parquet
	duckdb -c "copy (select final_search_term from '$<') to stdout (delimiter '\t', header false);" > $@

%.snappy.parquet :
	curl -L -C - "$(DATAURL)"/$@?download=true > $@

.DELETE_ON_ERROR :
