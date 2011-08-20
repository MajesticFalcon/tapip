MAKEFLAGS += --no-print-directory

CC = gcc
CFLAGS = -lpthread -Wall

NET_STACK_OBJS =	test/test_obj.o	\
			net/net_obj.o	\
			arp/arp_obj.o	\
			ip/ip_obj.o	\
			lib/lib_obj.o

all:net_stack
net_stack:$(NET_STACK_OBJS)
	$(CC) $(CFLAGS) $^ -o $@

test/test_obj.o:test/shell.c test/test.c\
		test/net_command.c test/ping_command.c
	@(cd test/; make)
net/net_obj.o:net/net.c net/netdev.c net/tap.c net/pkb.c net/veth.c net/loop.c
	@(cd net/; make)
arp/arp_obj.o:arp/arp.c arp/arp_cache.c
	@(cd arp/; make)
ip/ip_obj.o:ip/ip.c ip/route.c ip/ip_frag.c ip/icmp.c
	@(cd ip/; make)
lib/lib_obj.o:lib/lib.c lib/checksum.c
	@(cd lib/; make)

tag:
	ctags -R *

clean:
	@(cd net/; make clean)
	@(cd test/; make clean)
	@(cd arp/; make clean)
	@(cd ip/; make clean)
	@(cd lib/; make clean)
	rm -f net_stack

lines:
	@echo "code lines:"
	@wc -l `find . -name \*.[ch]` | sort -n

