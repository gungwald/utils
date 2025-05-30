# OS specific part
ifeq ($(OS),Windows_NT)
    RM = del /F /Q
    RMDIR = -RMDIR /S /Q
    MKDIR = -mkdir
    ERRIGNORE = 2>NUL || true
    SEP=\\
else
    RM = rm -rf
    RMDIR = rm -rf
    MKDIR = mkdir -p
    ERRIGNORE = 2>/dev/null
    SEP=/
endif

JAVAC=$(HOME)/Dropbox/opt/j2sdk1.4.2/j2sdk1.4.2_19/bin/javac
JAVAC=$(HOME)/Dropbox/opt/jdk1.5.0/jdk1.5.0_22/bin/javac

SOURCE_DIR=../src
CLASSES_DIR=../classes
JFLAGS=-source 1.3 -target 1.1 -g

COMPILE.java=$(JAVAC) $(JFLAGS)
OUTPUT_OPTION=-d $(CLASSES_DIR)
SOURCES = $(foreach dir,$(SOURCE_DIR),$(wildcard $(dir)/*.java))
CLASSES := $(subst $(SOURCE_DIR),$(CLASSES_DIR),$(SOURCES:.java=.class))

all: $(CLASSES_DIR) $(CLASSES)

$(CLASSES_DIR):
	$(MKDIR) $(CLASSES_DIR)

$(CLASSES_DIR)/%.class: %.java
	$(COMPILE.java) $(OUTPUT_OPTION) $^

clean:
	$(RMDIR) $(CLASSES_DIR)

