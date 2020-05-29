.PHONY: default

default: expr

expr: expr.lex.c expr.tab.c
	gcc -o expr expr.lex.c expr.tab.c -lfl

expr.lex.c: expr.l expr.tab.h
	flex -s -oexpr.lex.c expr.l

expr.tab.c expr.tab.h: expr.y
	bison -dv expr.y

clean:
	cmd /c erase expr.lex.c expr.tab.h expr.tab.c expr expr.exe expr.output






