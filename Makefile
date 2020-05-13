CC = gcc
CFLAGS = -Wextra -lfl
DIR = src
YYTABH = $(DIR)/y.tab.h
YYTABC = $(DIR)/y.tab.c
LEXOUT = $(DIR)/lex.yy.c
YACCFILE = $(DIR)/trab.y
LEXFILE = $(DIR)/trab.l
TARGET = ./main
BJS = $(SRCS:.c=.o)
YACC = bison
LEX = flex

BASH = sh
TEST_SCRIPT = test.sh
VERBOSE ?= 1


all: $(TARGET)

$(TARGET):$(LEXOUT) $(YYTABC)
	$(CC) -o$(TARGET) $(LEXOUT) $(YYTABC) $(CFLAGS)

$(LEXOUT):$(LEXFILE) $(YYTABC)
	$(LEX) -o$(LEXOUT) $(LEXFILE)

$(YYTABC):$(YACCFILE)
	$(YACC) -o$(YYTABC) -dy $(YACCFILE)

test:all
	$(BASH) $(TEST_SCRIPT) $(TARGET) $(VERBOSE)

clean:
	$(RM) $(YYTABC)
	$(RM) $(YYTABH)
	$(RM) $(LEXOUT)
	$(RM) ./$(TARGET)
	$(RM) $(DIR)/*.o
