.PHONY: all clean compile

SRCS=${wildcard src/*.erl src/*/*.erl src/*/*/*.erl}
MODS=${basename ${notdir ${SRCS}}}
VPATH=${dir ${SRCS}} ebin

ERLC=erlc
CFLG=-o ebin -I include -W -v

all:compile

compile:${MODS:%=%.beam}

%.beam:%.erl
	${ERLC} ${CFLG} $<

run:
	cd etc && erl +K true +P 1024000 -pa ../ebin -name gateway22@127.0.0.1 \
	-setcookie wolf -boot start_sasl --config sasl.config \
	-s entry start gc_gateway_app -s mnesia -test

clean:
	-rm -rf ebin/*
