CLASSES_DIR=../classes
CLASSES=$(CLASSES_DIR)/MavenJarProjectCreator.class $(CLASSES_DIR)/Executor.class $(CLASSES_DIR)/ToLowerCase.class $(CLASSES_DIR)/BuildSqlInList.class $(CLASSES_DIR)/SetDiff.class $(CLASSES_DIR)/RemoveBlankLines.class
JAVAC=$(HOME)/Dropbox/opt/j2sdk1.4.2/j2sdk1.4.2_19/bin/javac

all: $(CLASSES)

$(CLASSES_DIR)/SetDiff.class: SetDiff.java
	$(JAVAC) -d $(CLASSES_DIR) SetDiff.java

$(CLASSES_DIR)/BuildSqlInList.class: BuildSqlInList.java
	$(JAVAC) -d $(CLASSES_DIR) BuildSqlInList.java

$(CLASSES_DIR)/MavenJarProjectCreator.class: MavenJarProjectCreator.java
	$(JAVAC) -d $(CLASSES_DIR) MavenJarProjectCreator.java

$(CLASSES_DIR)/Executor.class: Executor.java
	$(JAVAC) -d $(CLASSES_DIR) Executor.java

$(CLASSES_DIR)/ToLowerCase.class: ToLowerCase.java
	$(JAVAC) -d $(CLASSES_DIR) ToLowerCase.java

$(CLASSES_DIR)/RemoveBlankLines.class: RemoveBlankLines.java
	$(JAVAC) -d $(CLASSES_DIR) RemoveBlankLines.java

clean:
	$(RM) $(CLASSES)