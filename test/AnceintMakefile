
TARGET = -p xilinx -chip xc7v585t -speed 3 -pkg ffg1157 -chip-ratio 80% -freq 1M

SRC = idct.c


.PHONY: sched explo clean

sched:
	rm -rf vhdl xstprj
	augh -v $(TARGET) -script augh-cmd-sched $(SRC)

explo:
	rm -rf vhdl xstprj
	augh -v $(TARGET) -script augh-cmd-explo $(SRC)

clean:
	rm -rf vhdl xstprj exploration-data fork-output dupimplem.stdout
