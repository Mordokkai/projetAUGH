
TARGET = 

TARGETS = faux-chemins/1-faux-chemin/vhdl faux-chemins/2-sortie-active/vhdl

SRC = idct.c


.PHONY: sched explo clean

all: $(TARGETS)

clean:
	rm -rf vhdl xstprj exploration-data fork-output dupimplem.stdout
	rm -rf $(TARGETS)

%/auto-augh-exec:
	@echo "generating augh script"
	@echo > $@ "#generated script"
	@echo >> $@ "#do not modify, may be overwriten"
	@echo >> $@
	@echo >> $@ "commands-disp"
	@echo >> $@ "plugin load xilinx"
	@echo >> $@ "cd "`dirname $@`
	@echo >> $@ "load *.c"
	@echo >> $@ "hier upd"
	@echo >> $@ "techno set-techno virtex-5"
	@echo >> $@ "techno set-chip xc5vlx50t"
	@echo >> $@ "target-freq 100M"
	@echo >> $@ "hier time disp"
	@echo >> $@ "hier clockcycles"
	@echo >> $@ "map postmap-timing true"
	@echo >> $@ "postprocess"
	@echo >> $@ "techno eval"
	@echo >> $@ "vhdl"
	@echo >> $@ "plugin load falsepath"
	@echo >> $@ "plugin cmd falsepath search"
	cp $@ .
	
	
%/vhdl: %/*.c %/auto-augh-exec
	rm -rf $@
	@if [ -f `dirname $@`/augh-exec ] ; then \
	    echo > `dirname $@`/auto-augh-exec "#(semi)auto-generated file, DO NOT MODIFY"; \
	    cat `dirname $@`/augh-exec >> `dirname $@`/auto-augh-exec ; \
	fi
	augh -v $(TARGET) -script `dirname $@`/auto-augh-exec

