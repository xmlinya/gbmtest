# Makefile

# Set the cross compiler and target file system path
CROSS_COMPILE=arm-linux-gnueabihf-

## No need to change below this
FSDIR = ${SDK_PATH_TARGET}
COMMON_INCLUDES = -I$(FSDIR)/usr/include
COMMON_LFLAGS = -L$(FSDIR)/usr/lib -Wl,--rpath-link,$(FSDIR)/usr/lib

PLAT_CPP = $(CROSS_COMPILE)gcc

PLAT_CFLAGS   = $(COMMON_INCLUDES) -g
PLAT_LINK =  $(COMMON_LFLAGS) -lEGL -lGLESv2 -ludev -lpthread -lm -lrt

SRCNAME = kmscube.c 


PLAT_CFLAGS += -I$(FSDIR)/usr/include/libdrm -I$(FSDIR)/usr/include/gbm
PLAT_LINK += -lgbm -ldrm
OUTNAME = gbmtest


OBJECTS = $(SRCNAME:.c=.o)

$(OUTNAME): $(SRCNAME)
	$(PLAT_CPP) -o $@ $^ $(PLAT_CFLAGS) $(LINK) $(PLAT_LINK)

install:
	cp $(OUTNAME) $(FSDIR)/home/root

clean:
	rm $(OUTNAME)
