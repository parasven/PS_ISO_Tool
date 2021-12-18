# -----------------------------------------------------------------
# PS ISO Tool MSYS/MINGW Makefile (uses GCC compiler)(CaptainCPS-X, 2013)
# -----------------------------------------------------------------
# Edit Parasven 18122021: Added -DLINUXLOCAL flag to make it use linux /usr/local Path for databases paths.
# 		 	  sudo make install will install everything under /usr/local/
# 		 	  sudo make uninstall will remove all files.
#
TARGET		:= 	bin/psiso_tool
CC		:= 	g++
CXXFLAGS 	:= 	-O1 -Wl,-subsystem,console -Wall -W -DLINUXLOCAL
LDFLAGS 	:= 	-static-libgcc -static-libstdc++
#LIBS		:=	-lkernel32 -lshell32 -luser32
INCLUDES	:= 	-Isource

SRCS		:= 	source/psiso_tool.cpp \
				source/psiso_tool_main.cpp

OBJS		:=	$(SRCS:.cpp=.o)
PREFIX		:=	/usr/local

vpath %.cpp source
vpath %.obj source

.DEFAULT_GOAL := all

.PHONY : cleanup
cleanup :
	@rm -fr $(OBJS)
	@rm -fr $(TARGET)

all: $(TARGET)
	
$(TARGET): $(OBJS)
	@echo "Linking object files ..."
	@$(CC) $(LDFLAGS) -o $(TARGET) $(OBJS) $(LIBS)

%.o: %.cpp
	@echo "Compiling $(<F) $(@F) ..."
	@echo .
	@$(CC) $(CXXFLAGS) $(INCLUDES) -o $@ -c $<

install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 755 bin/psiso_tool $(DESTDIR)$(PREFIX)/bin/
	install -d $(DESTDIR)$(PREFIX)/etc/psisotool_dbs/
	install -m 644 bin/db/ps1titles_us_eu_jp.txt $(DESTDIR)$(PREFIX)/etc/psisotool_dbs/
	install -m 644 bin/db/ps2titleid.txt $(DESTDIR)$(PREFIX)/etc/psisotool_dbs/

uninstall:
	rm -i $(DESTDIR)$(PREFIX)/bin/psiso_tool
	rm -i $(DESTDIR)$(PREFIX)/etc/psisotool_dbs/ps1titles_us_eu_jp.txt
	rm -i $(DESTDIR)$(PREFIX)/etc/psisotool_dbs/ps2titleid.txt
	rmdir $(DESTDIR)$(PREFIX)/etc/psisotool_dbs
