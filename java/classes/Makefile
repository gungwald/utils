CLASSES_DIR=../classes
CLASSES=$(CLASSES_DIR)/MavenJarProjectCreator.class $(CLASSES_DIR)/Executor.class
JAVAC=$(HOME)/Dropbox/opt/j2sdk1.4.2_19/bin/javac

all: $(CLASSES)

$(CLASSES_DIR)/MavenJarProjectCreator.class: MavenJarProjectCreator.java
	$(JAVAC) -d $(CLASSES_DIR) MavenJarProjectCreator.java

$(CLASSES_DIR)/Executor.class: Executor.java
	$(JAVAC) -d $(CLASSES_DIR) Executor.java

clean:
	$(RM) $(CLASSES)