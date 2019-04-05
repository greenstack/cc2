BUILD_DIR = ./build
CC2 = cc2.love
EXCLUDES = -x $(BUILD_DIR) readme.md .git* *.tsx *.tmx
FLAGS = -r

all: cc2

cc2:
	zip $(FLAGS) $(BUILD_DIR)/$(CC2) ./* $(EXCLUDES)

clean:
	rm -f *~ $(BUILD_DIR)/$(CC2)
