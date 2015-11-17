
TARGET = 

SRC = idct.c


.PHONY: sched explo clean

all: faux-chemins/1-faux-chemin/vhdl

sched:
	rm -rf vhdl xstprj
	augh -v $(TARGET) -script augh-cmd-sched $(SRC)

explo:
	rm -rf vhdl xstprj
	augh -v $(TARGET) -script augh-cmd-explo $(SRC)

clean:
	rm -rf vhdl xstprj exploration-data fork-output dupimplem.stdout

%/augh-exec:
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
	
	
%/vhdl: %/*.c %/augh-exec
	rm -rf $@
	augh -v $(TARGET) -script `dirname $@`/augh-exec
	

