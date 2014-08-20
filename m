Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:43007 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaHTXSX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:23 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so7841770wib.14
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:21 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/8] initial commit
Date: Thu, 21 Aug 2014 01:17:51 +0200
Message-Id: <1408576677-28149-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch is just copy&paste everything from the iw tool and change 80211
to 802154. Also wireless to wpan. Also add handling for add and remove
interfaces like the iw command just for wpan devices.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 Makefile.am     |  23 +++
 autogen.sh      |  25 +++
 configure.ac    |  73 ++++++++
 src/Makefile.am |  10 ++
 src/interface.c | 100 +++++++++++
 src/iwpan.c     | 534 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/iwpan.h     | 113 ++++++++++++
 src/nl802154.h  |  88 ++++++++++
 src/sections.c  |   4 +
 9 files changed, 970 insertions(+)
 create mode 100644 Makefile.am
 create mode 100755 autogen.sh
 create mode 100644 configure.ac
 create mode 100644 src/Makefile.am
 create mode 100644 src/interface.c
 create mode 100644 src/iwpan.c
 create mode 100644 src/iwpan.h
 create mode 100644 src/nl802154.h
 create mode 100644 src/sections.c

diff --git a/Makefile.am b/Makefile.am
new file mode 100644
index 0000000..06c72cd
--- /dev/null
+++ b/Makefile.am
@@ -0,0 +1,23 @@
+EXTRA_DIST =
+CLEANFILES =
+ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
+AM_MAKEFLAGS = --no-print-directory
+
+AM_CPPFLAGS = \
+	-include $(top_builddir)/config.h \
+	-DSYSCONFDIR=\""$(sysconfdir)"\" \
+	-DLIBEXECDIR=\""$(libexecdir)"\" \
+	-I${top_srcdir}/src/abc \
+	-I${top_srcdir}/src
+
+AM_CFLAGS = ${WPAN_TOOLS_CFLAGS} \
+	-fvisibility=hidden \
+	-ffunction-sections \
+	-fdata-sections
+
+AM_LDFLAGS = \
+	-Wl,--gc-sections \
+	-Wl,--as-needed
+
+SUBDIRS = \
+	src
diff --git a/autogen.sh b/autogen.sh
new file mode 100755
index 0000000..0d60b0a
--- /dev/null
+++ b/autogen.sh
@@ -0,0 +1,25 @@
+#!/bin/sh -e
+
+if [ -f .git/hooks/pre-commit.sample -a ! -f .git/hooks/pre-commit ] ; then
+        cp -p .git/hooks/pre-commit.sample .git/hooks/pre-commit && \
+        chmod +x .git/hooks/pre-commit && \
+        echo "Activated pre-commit hook."
+fi
+
+autoreconf --install --symlink
+
+libdir() {
+        echo $(cd $1/$(gcc -print-multi-os-directory); pwd)
+}
+
+args="--prefix=/usr \
+--sysconfdir=/etc \
+--libdir=$(libdir /usr/lib)"
+
+echo
+echo "----------------------------------------------------------------"
+echo "Initialized build system. For a common configuration please run:"
+echo "----------------------------------------------------------------"
+echo
+echo "./configure CFLAGS='-g -O0' $args"
+echo
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..791607f
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,73 @@
+AC_PREREQ(2.60)
+AC_INIT([Userspace tools for Linux IEEE 802.15.4 stack],
+	[0.1], [linux-wpan@vger.kernel.org], [wpan-tools],
+	[https://github.com/linux-wpan/wpan-tools])
+AC_CONFIG_SRCDIR([src/iwpan.c])
+AC_CONFIG_AUX_DIR([build-aux])
+AM_INIT_AUTOMAKE([
+	check-news
+	foreign
+	1.11
+	-Wall
+	-Werror
+	-Wno-portability
+	silent-rules
+	tar-pax
+	no-dist-gzip
+	dist-xz
+	subdir-objects
+])
+AC_PROG_CC_STDC
+AC_USE_SYSTEM_EXTENSIONS
+AC_SYS_LARGEFILE
+AC_CONFIG_MACRO_DIR([m4])
+AM_SILENT_RULES([yes])
+LT_INIT([
+	disable-static
+	pic-only
+])
+AC_PREFIX_DEFAULT([/usr])
+
+AC_PROG_SED
+AC_PROG_MKDIR_P
+
+PKG_CHECK_MODULES(LIBNL3, [libnl-3.0 >= 3.1 libnl-genl-3.0 >= 3.1], [have_libnl3=yes], [have_libnl3=no])
+
+AC_CHECK_FUNCS([ \
+	__secure_getenv \
+	secure_getenv\
+])
+
+my_CFLAGS="\
+-Wall \
+-Wchar-subscripts \
+-Wformat-security \
+-Wmissing-declarations \
+-Wmissing-prototypes \
+-Wnested-externs \
+-Wpointer-arith \
+-Wshadow \
+-Wsign-compare \
+-Wstrict-prototypes \
+-Wtype-limits \
+"
+AC_SUBST([WPAN_TOOLS_CFLAGS])
+
+AC_CONFIG_HEADERS(config.h)
+AC_CONFIG_FILES([
+        Makefile
+	src/Makefile
+])
+
+AC_OUTPUT
+AC_MSG_RESULT([
+        $PACKAGE $VERSION
+        =====
+
+        prefix:                 ${prefix}
+        sysconfdir:             ${sysconfdir}
+
+        compiler:               ${CC}
+        cflags:                 ${CFLAGS}
+        ldflags:                ${LDFLAGS}
+])
diff --git a/src/Makefile.am b/src/Makefile.am
new file mode 100644
index 0000000..9b42fc1
--- /dev/null
+++ b/src/Makefile.am
@@ -0,0 +1,10 @@
+bin_PROGRAMS = \
+	iwpan
+
+iwpan_SOURCES = \
+	iwpan.c \
+	sections.c \
+	interface.c
+
+iwpan_CFLAGS = $(AM_CFLAGS) $(LIBNL3_CFLAGS)
+iwpan_LDADD = $(LIBNL3_LIBS)
diff --git a/src/interface.c b/src/interface.c
new file mode 100644
index 0000000..e3253c4
--- /dev/null
+++ b/src/interface.c
@@ -0,0 +1,100 @@
+#include <net/if.h>
+#include <errno.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "nl802154.h"
+#include "iwpan.h"
+
+SECTION(interface);
+
+/* for help */
+#define IFACE_TYPES "Valid interface types are: node, monitor, coordinator."
+
+/* return 0 if ok, internal error otherwise */
+static int get_if_type(int *argc, char ***argv, enum nl802154_iftype *type,
+		       bool need_type)
+{
+	char *tpstr;
+
+	if (*argc < 1 + !!need_type)
+		return 1;
+
+	if (need_type && strcmp((*argv)[0], "type"))
+		return 1;
+
+	tpstr = (*argv)[!!need_type];
+	*argc -= 1 + !!need_type;
+	*argv += 1 + !!need_type;
+
+	if (strcmp(tpstr, "node") == 0) {
+		*type = NL802154_IFTYPE_NODE;
+		return 0;
+	} else if (strcmp(tpstr, "monitor") == 0) {
+		*type = NL802154_IFTYPE_MONITOR;
+		return 0;
+	} else if (strcmp(tpstr, "coordinator") == 0) {
+		*type = NL802154_IFTYPE_COORD;
+		return 0;
+	}
+
+	fprintf(stderr, "invalid interface type %s\n", tpstr);
+	return 2;
+}
+
+static int handle_interface_add(struct nl802154_state *state,
+				struct nl_cb *cb,
+				struct nl_msg *msg,
+				int argc, char **argv,
+				enum id_input id)
+{
+	char *name;
+	enum nl802154_iftype type;
+	int tpset;
+
+	if (argc < 1)
+		return 1;
+
+	name = argv[0];
+	argc--;
+	argv++;
+
+	tpset = get_if_type(&argc, &argv, &type, true);
+	if (tpset)
+		return tpset;
+
+	if (argc)
+		return 1;
+
+	NLA_PUT_STRING(msg, NL802154_ATTR_IFNAME, name);
+	NLA_PUT_U32(msg, NL802154_ATTR_IFTYPE, type);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(interface, add, "<name> type <type>",
+	NL802154_CMD_NEW_INTERFACE, 0, CIB_PHY, handle_interface_add,
+	"Add a new virtual interface with the given configuration.\n"
+	IFACE_TYPES "\n\n");
+COMMAND(interface, add, "<name> type <type>",
+	NL802154_CMD_NEW_INTERFACE, 0, CIB_NETDEV, handle_interface_add, NULL);
+
+static int handle_interface_del(struct nl802154_state *state,
+				struct nl_cb *cb,
+				struct nl_msg *msg,
+				int argc, char **argv,
+				enum id_input id)
+{
+	return 0;
+}
+TOPLEVEL(del, NULL, NL802154_CMD_DEL_INTERFACE, 0, CIB_NETDEV, handle_interface_del,
+	 "Remove this virtual interface");
+HIDDEN(interface, del, NULL, NL802154_CMD_DEL_INTERFACE, 0, CIB_NETDEV, handle_interface_del);
diff --git a/src/iwpan.c b/src/iwpan.c
new file mode 100644
index 0000000..73d5ba3
--- /dev/null
+++ b/src/iwpan.c
@@ -0,0 +1,534 @@
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <net/if.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "nl802154.h"
+#include "iwpan.h"
+
+/* TODO libnl 1.x compatibility code */
+
+int iwpan_debug = 0;
+
+static int nl802154_init(struct nl802154_state *state)
+{
+	int err;
+
+	state->nl_sock = nl_socket_alloc();
+	if (!state->nl_sock) {
+		fprintf(stderr, "Failed to allocate netlink socket.\n");
+		return -ENOMEM;
+	}
+
+	nl_socket_set_buffer_size(state->nl_sock, 8192, 8192);
+
+	if (genl_connect(state->nl_sock)) {
+		fprintf(stderr, "Failed to connect to generic netlink.\n");
+		err = -ENOLINK;
+		goto out_handle_destroy;
+	}
+
+	state->nl802154_id = genl_ctrl_resolve(state->nl_sock, "nl802154");
+	if (state->nl802154_id < 0) {
+		fprintf(stderr, "nl802154 not found.\n");
+		err = -ENOENT;
+		goto out_handle_destroy;
+	}
+
+	return 0;
+
+out_handle_destroy:
+	nl_socket_free(state->nl_sock);
+	return err;
+}
+
+static void nl802154_cleanup(struct nl802154_state *state)
+{
+	nl_socket_free(state->nl_sock);
+}
+
+static int cmd_size;
+
+extern struct cmd __start___cmd;
+extern struct cmd __stop___cmd;
+
+static void __usage_cmd(const struct cmd *cmd, char *indent, bool full)
+{
+	const char *start, *lend, *end;
+
+	printf("%s", indent);
+
+	switch (cmd->idby) {
+	case CIB_NONE:
+		break;
+	case CIB_PHY:
+		printf("phy <phyname> ");
+		break;
+	case CIB_NETDEV:
+		printf("dev <devname> ");
+		break;
+	case CIB_WPAN_DEV:
+		printf("wdev <idx> ");
+		break;
+	}
+	if (cmd->parent && cmd->parent->name)
+		printf("%s ", cmd->parent->name);
+	printf("%s", cmd->name);
+
+	if (cmd->args) {
+		/* print line by line */
+		start = cmd->args;
+		end = strchr(start, '\0');
+		printf(" ");
+		do {
+			lend = strchr(start, '\n');
+			if (!lend)
+				lend = end;
+			if (start != cmd->args) {
+				printf("\t");
+				switch (cmd->idby) {
+				case CIB_NONE:
+					break;
+				case CIB_PHY:
+					printf("phy <phyname> ");
+					break;
+				case CIB_NETDEV:
+					printf("dev <devname> ");
+					break;
+				case CIB_WPAN_DEV:
+					printf("wdev <idx> ");
+					break;
+				}
+				if (cmd->parent && cmd->parent->name)
+					printf("%s ", cmd->parent->name);
+				printf("%s ", cmd->name);
+			}
+			printf("%.*s\n", (int)(lend - start), start);
+			start = lend + 1;
+		} while (end != lend);
+	} else
+		printf("\n");
+
+	if (!full || !cmd->help)
+		return;
+
+	/* hack */
+	if (strlen(indent))
+		indent = "\t\t";
+	else
+		printf("\n");
+
+	/* print line by line */
+	start = cmd->help;
+	end = strchr(start, '\0');
+	do {
+		lend = strchr(start, '\n');
+		if (!lend)
+			lend = end;
+		printf("%s", indent);
+		printf("%.*s\n", (int)(lend - start), start);
+		start = lend + 1;
+	} while (end != lend);
+
+	printf("\n");
+}
+
+#define for_each_cmd(_cmd)						\
+	for (_cmd = &__start___cmd; _cmd < &__stop___cmd;		\
+	     _cmd = (const struct cmd *)((char *)_cmd + cmd_size))
+
+static void usage_options(void)
+{
+	printf("Options:\n");
+	printf("\t--debug\t\tenable netlink debugging\n");
+}
+
+static const char *argv0;
+
+static void usage(int argc, char **argv)
+{
+	const struct cmd *section, *cmd;
+	bool full = argc >= 0;
+	const char *sect_filt = NULL;
+	const char *cmd_filt = NULL;
+
+	if (argc > 0)
+		sect_filt = argv[0];
+
+	if (argc > 1)
+		cmd_filt = argv[1];
+
+	printf("Usage:\t%s [options] command\n", argv0);
+	usage_options();
+	/* TODO */
+	printf("\t--version\tshow version (0.1)\n");
+	printf("Commands:\n");
+	for_each_cmd(section) {
+		if (section->parent)
+			continue;
+
+		if (sect_filt && strcmp(section->name, sect_filt))
+			continue;
+
+		if (section->handler && !section->hidden)
+			__usage_cmd(section, "\t", full);
+
+		for_each_cmd(cmd) {
+			if (section != cmd->parent)
+				continue;
+			if (!cmd->handler || cmd->hidden)
+				continue;
+			if (cmd_filt && strcmp(cmd->name, cmd_filt))
+				continue;
+			__usage_cmd(cmd, "\t", full);
+		}
+	}
+	printf("\nCommands that use the netdev ('dev') can also be given the\n"
+	       "'wdev' instead to identify the device.\n");
+	printf("\nYou can omit the 'phy' or 'dev' if "
+			"the identification is unique,\n"
+			"e.g. \"iwpan wpan0 info\" or \"iwpan phy0 info\". "
+			"(Don't when scripting.)\n\n"
+			"Do NOT screenscrape this tool, we don't "
+			"consider its output stable.\n\n");
+}
+
+static void usage_cmd(const struct cmd *cmd)
+{
+	printf("Usage:\t%s [options] ", argv0);
+	__usage_cmd(cmd, "", true);
+	usage_options();
+}
+
+static void version(void)
+{
+	/* TODO */
+	printf("iwpan version 0.1\n");
+}
+
+static int phy_lookup(char *name)
+{
+	char buf[200];
+	int fd, pos;
+
+	snprintf(buf, sizeof(buf), "/sys/class/ieee802154/%s/index", name);
+
+	fd = open(buf, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	pos = read(fd, buf, sizeof(buf) - 1);
+	if (pos < 0) {
+		close(fd);
+		return -1;
+	}
+	buf[pos] = '\0';
+	close(fd);
+	return atoi(buf);
+}
+
+static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
+			 void *arg)
+{
+	int *ret = arg;
+	*ret = err->error;
+	return NL_STOP;
+}
+
+static int finish_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+	*ret = 0;
+	return NL_SKIP;
+}
+
+static int ack_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+	*ret = 0;
+	return NL_STOP;
+}
+
+static int __handle_cmd(struct nl802154_state *state, enum id_input idby,
+			int argc, char **argv, const struct cmd **cmdout)
+{
+	const struct cmd *cmd, *match = NULL, *sectcmd;
+	struct nl_cb *cb;
+	struct nl_cb *s_cb;
+	struct nl_msg *msg;
+	signed long long devidx = 0;
+	int err, o_argc;
+	const char *command, *section;
+	char *tmp, **o_argv;
+	enum command_identify_by command_idby = CIB_NONE;
+
+	if (argc <= 1 && idby != II_NONE)
+		return 1;
+
+	o_argc = argc;
+	o_argv = argv;
+
+	switch (idby) {
+	case II_PHY_IDX:
+		command_idby = CIB_PHY;
+		devidx = strtoul(*argv + 4, &tmp, 0);
+		if (*tmp != '\0')
+			return 1;
+		argc--;
+		argv++;
+		break;
+	case II_PHY_NAME:
+		command_idby = CIB_PHY;
+		devidx = phy_lookup(*argv);
+		argc--;
+		argv++;
+		break;
+	case II_NETDEV:
+		command_idby = CIB_NETDEV;
+		devidx = if_nametoindex(*argv);
+		if (devidx == 0)
+			devidx = -1;
+		argc--;
+		argv++;
+		break;
+	case II_WPAN_DEV:
+		command_idby = CIB_WPAN_DEV;
+		devidx = strtoll(*argv, &tmp, 0);
+		if (*tmp != '\0')
+			return 1;
+		argc--;
+		argv++;
+	default:
+		break;
+	}
+
+	if (devidx < 0)
+		return -errno;
+
+	section = *argv;
+	argc--;
+	argv++;
+
+	for_each_cmd(sectcmd) {
+		if (sectcmd->parent)
+			continue;
+		/* ok ... bit of a hack for the dupe 'info' section */
+		if (match && sectcmd->idby != command_idby)
+			continue;
+		if (strcmp(sectcmd->name, section) == 0)
+			match = sectcmd;
+	}
+
+	sectcmd = match;
+	match = NULL;
+	if (!sectcmd)
+		return 1;
+
+	if (argc > 0) {
+		command = *argv;
+
+		for_each_cmd(cmd) {
+			if (!cmd->handler)
+				continue;
+			if (cmd->parent != sectcmd)
+				continue;
+			/*
+			 * ignore mismatch id by, but allow WPAN_DEV
+			 * in place of NETDEV
+			 */
+			if (cmd->idby != command_idby &&
+			    !(cmd->idby == CIB_NETDEV &&
+			      command_idby == CIB_WPAN_DEV))
+				continue;
+			if (strcmp(cmd->name, command))
+				continue;
+			if (argc > 1 && !cmd->args)
+				continue;
+			match = cmd;
+			break;
+		}
+
+		if (match) {
+			argc--;
+			argv++;
+		}
+	}
+
+	if (match)
+		cmd = match;
+	else {
+		/* Use the section itself, if possible. */
+		cmd = sectcmd;
+		if (argc && !cmd->args)
+			return 1;
+		if (cmd->idby != command_idby &&
+		    !(cmd->idby == CIB_NETDEV && command_idby == CIB_WPAN_DEV))
+			return 1;
+		if (!cmd->handler)
+			return 1;
+	}
+
+	if (cmd->selector) {
+		cmd = cmd->selector(argc, argv);
+		if (!cmd)
+			return 1;
+	}
+
+	if (cmdout)
+		*cmdout = cmd;
+
+	if (!cmd->cmd) {
+		argc = o_argc;
+		argv = o_argv;
+		return cmd->handler(state, NULL, NULL, argc, argv, idby);
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		fprintf(stderr, "failed to allocate netlink message\n");
+		return 2;
+	}
+
+	cb = nl_cb_alloc(iwpan_debug ? NL_CB_DEBUG : NL_CB_DEFAULT);
+	s_cb = nl_cb_alloc(iwpan_debug ? NL_CB_DEBUG : NL_CB_DEFAULT);
+	if (!cb || !s_cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		err = 2;
+		goto out_free_msg;
+	}
+
+	genlmsg_put(msg, 0, 0, state->nl802154_id, 0,
+		    cmd->nl_msg_flags, cmd->cmd, 0);
+
+	switch (command_idby) {
+	case CIB_PHY:
+		NLA_PUT_U32(msg, NL802154_ATTR_WPAN_PHY, devidx);
+		break;
+	case CIB_NETDEV:
+		NLA_PUT_U32(msg, NL802154_ATTR_IFINDEX, devidx);
+		break;
+	case CIB_WPAN_DEV:
+		NLA_PUT_U64(msg, NL802154_ATTR_WPAN_DEV, devidx);
+		break;
+	default:
+		break;
+	}
+
+	err = cmd->handler(state, cb, msg, argc, argv, idby);
+	if (err)
+		goto out;
+
+	nl_socket_set_cb(state->nl_sock, s_cb);
+
+	err = nl_send_auto_complete(state->nl_sock, msg);
+	if (err < 0)
+		goto out;
+
+	err = 1;
+
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &err);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &err);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &err);
+
+	while (err > 0)
+		nl_recvmsgs(state->nl_sock, cb);
+out:
+	nl_cb_put(cb);
+out_free_msg:
+	nlmsg_free(msg);
+	return err;
+nla_put_failure:
+	fprintf(stderr, "building message failed\n");
+	return 2;
+}
+
+int handle_cmd(struct nl802154_state *state, enum id_input idby,
+	       int argc, char **argv)
+{
+	return __handle_cmd(state, idby, argc, argv, NULL);
+}
+
+int main(int argc, char **argv)
+{
+	struct nl802154_state nlstate;
+	const struct cmd *cmd = NULL;
+	int err;
+
+	/* calculate command size including padding */
+	cmd_size = abs((long)&__section_set - (long)&__section_get);
+	/* strip off self */
+	argc--;
+	argv0 = *argv++;
+
+	if (argc > 0 && strcmp(*argv, "--debug") == 0) {
+		iwpan_debug = 1;
+		argc--;
+		argv++;
+	}
+
+	if (argc > 0 && strcmp(*argv, "--version") == 0) {
+		version();
+		return 0;
+	}
+
+	/* need to treat "help" command specially so it works w/o nl802154 */
+	if (argc == 0 || strcmp(*argv, "help") == 0) {
+		usage(argc - 1, argv + 1);
+		return 0;
+	}
+
+	err = nl802154_init(&nlstate);
+	if (err)
+		return 1;
+
+	if (strcmp(*argv, "dev") == 0 && argc > 1) {
+		argc--;
+		argv++;
+		err = __handle_cmd(&nlstate, II_NETDEV, argc, argv, &cmd);
+	} else if (strncmp(*argv, "phy", 3) == 0 && argc > 1) {
+		if (strlen(*argv) == 3) {
+			argc--;
+			argv++;
+			err = __handle_cmd(&nlstate, II_PHY_NAME, argc, argv, &cmd);
+		} else if (*(*argv + 3) == '#')
+			err = __handle_cmd(&nlstate, II_PHY_IDX, argc, argv, &cmd);
+		else
+			goto detect;
+	} else if (strcmp(*argv, "wdev") == 0 && argc > 1) {
+		argc--;
+		argv++;
+		err = __handle_cmd(&nlstate, II_WPAN_DEV, argc, argv, &cmd);
+	} else {
+		int idx;
+		enum id_input idby = II_NONE;
+ detect:
+		if ((idx = if_nametoindex(argv[0])) != 0)
+			idby = II_NETDEV;
+		else if ((idx = phy_lookup(argv[0])) >= 0)
+			idby = II_PHY_NAME;
+		err = __handle_cmd(&nlstate, idby, argc, argv, &cmd);
+	}
+
+	if (err == 1) {
+		if (cmd)
+			usage_cmd(cmd);
+		else
+			usage(0, NULL);
+	} else if (err < 0)
+		fprintf(stderr, "command failed: %s (%d)\n", strerror(-err), err);
+
+	nl802154_cleanup(&nlstate);
+
+	return err;
+}
diff --git a/src/iwpan.h b/src/iwpan.h
new file mode 100644
index 0000000..d35bd7a
--- /dev/null
+++ b/src/iwpan.h
@@ -0,0 +1,113 @@
+#ifndef __IWPAN_H
+#define __IWPAN_H
+
+#include <stdbool.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <endian.h>
+
+#include "nl802154.h"
+
+/* TODO libnl1 compatibility */
+//#define nl_sock nl_handle
+
+struct nl802154_state {
+	struct nl_sock *nl_sock;
+	int nl802154_id;
+};
+
+enum command_identify_by {
+	CIB_NONE,
+	CIB_PHY,
+	CIB_NETDEV,
+	CIB_WPAN_DEV,
+};
+
+enum id_input {
+	II_NONE,
+	II_NETDEV,
+	II_PHY_NAME,
+	II_PHY_IDX,
+	II_WPAN_DEV,
+};
+
+struct cmd {
+	const char *name;
+	const char *args;
+	const char *help;
+	const enum nl802154_commands cmd;
+	int nl_msg_flags;
+	int hidden;
+	const enum command_identify_by idby;
+	/* The handler should return a negative error code,
+	 * zero on success, 1 if the arguments were wrong
+	 * and the usage message should and 2 otherwise.
+	 */
+	int (*handler)(struct nl802154_state *state,
+		       struct nl_cb *cb,
+		       struct nl_msg *msg,
+		       int argc, char **argv,
+		       enum id_input id);
+	const struct cmd *(*selector)(int argc, char **argv);
+	const struct cmd *parent;
+};
+
+#define __COMMAND(_section, _symname, _name, _args, _nlcmd, _flags, _hidden, _idby, _handler, _help, _sel)\
+	static struct cmd						\
+	__cmd ## _ ## _symname ## _ ## _handler ## _ ## _nlcmd ## _ ## _idby ## _ ## _hidden\
+	__attribute__((used)) __attribute__((section("__cmd")))	= {	\
+		.name = (_name),					\
+		.args = (_args),					\
+		.cmd = (_nlcmd),					\
+		.nl_msg_flags = (_flags),				\
+		.hidden = (_hidden),					\
+		.idby = (_idby),					\
+		.handler = (_handler),					\
+		.help = (_help),					\
+		.parent = _section,					\
+		.selector = (_sel),					\
+	}
+#define __ACMD(_section, _symname, _name, _args, _nlcmd, _flags, _hidden, _idby, _handler, _help, _sel, _alias)\
+	__COMMAND(_section, _symname, _name, _args, _nlcmd, _flags, _hidden, _idby, _handler, _help, _sel);\
+	static const struct cmd *_alias = &__cmd ## _ ## _symname ## _ ## _handler ## _ ## _nlcmd ## _ ## _idby ## _ ## _hidden
+#define COMMAND(section, name, args, cmd, flags, idby, handler, help)	\
+	__COMMAND(&(__section ## _ ## section), name, #name, args, cmd, flags, 0, idby, handler, help, NULL)
+#define COMMAND_ALIAS(section, name, args, cmd, flags, idby, handler, help, selector, alias)\
+	__ACMD(&(__section ## _ ## section), name, #name, args, cmd, flags, 0, idby, handler, help, selector, alias)
+#define HIDDEN(section, name, args, cmd, flags, idby, handler)		\
+	__COMMAND(&(__section ## _ ## section), name, #name, args, cmd, flags, 1, idby, handler, NULL, NULL)
+#define TOPLEVEL(_name, _args, _nlcmd, _flags, _idby, _handler, _help)	\
+	struct cmd							\
+	__section ## _ ## _name						\
+	__attribute__((used)) __attribute__((section("__cmd")))	= {	\
+		.name = (#_name),					\
+		.args = (_args),					\
+		.cmd = (_nlcmd),					\
+		.nl_msg_flags = (_flags),				\
+		.idby = (_idby),					\
+		.handler = (_handler),					\
+		.help = (_help),					\
+	 }
+#define SECTION(_name)							\
+	struct cmd __section ## _ ## _name				\
+	__attribute__((used)) __attribute__((section("__cmd"))) = {	\
+		.name = (#_name),					\
+		.hidden = 1,						\
+	}
+
+#define SECTION(_name)							\
+	struct cmd __section ## _ ## _name				\
+	__attribute__((used)) __attribute__((section("__cmd"))) = {	\
+		.name = (#_name),					\
+		.hidden = 1,						\
+	}
+
+#define DECLARE_SECTION(_name)						\
+	extern struct cmd __section ## _ ## _name;
+
+DECLARE_SECTION(set);
+DECLARE_SECTION(get);
+
+#endif /* __IWPAN_H */
diff --git a/src/nl802154.h b/src/nl802154.h
new file mode 100644
index 0000000..c1f2f13
--- /dev/null
+++ b/src/nl802154.h
@@ -0,0 +1,88 @@
+/*
+ * nl802154.h
+ *
+ * Copyright (C) 2007, 2008, 2009 Siemens AG
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#ifndef __LINUX_NL802154_H
+#define __LINUX_NL802154_H
+
+#define NL802154_GENL_NAME "nl802154"
+
+/* commands */
+/* REQ should be responded with CONF
+ * and INDIC with RESP
+ */
+enum nl802154_commands {
+/* don't change the order or add anything between, this is ABI! */
+/* Currently we don't shipping this file via uapi, ignore the above one */
+	NL802154_CMD_UNSPEC,
+
+	NL802154_CMD_GET_WPAN_PHY,		/* can dump */
+	NL802154_CMD_SET_WPAN_PHY,
+	NL802154_CMD_NEW_WPAN_PHY,
+	NL802154_CMD_DEL_WPAN_PHY,
+
+	NL802154_CMD_GET_INTERFACE,		/* can dump */
+	NL802154_CMD_SET_INTERFACE,
+	NL802154_CMD_NEW_INTERFACE,
+	NL802154_CMD_DEL_INTERFACE,
+
+	/* add new commands above here */
+
+	/* used to define NL802154_CMD_MAX below */
+	__NL802154_CMD_AFTER_LAST,
+	NL802154_CMD_MAX = __NL802154_CMD_AFTER_LAST - 1
+};
+
+enum nl802154_attrs {
+/* don't change the order or add anything between, this is ABI! */
+/* Currently we don't shipping this file via uapi, ignore the above one */
+	NL802154_ATTR_UNSPEC,
+
+	NL802154_ATTR_WPAN_PHY,
+	NL802154_ATTR_WPAN_PHY_NAME,
+
+	NL802154_ATTR_IFINDEX,
+	NL802154_ATTR_IFNAME,
+	NL802154_ATTR_IFTYPE,
+
+	NL802154_ATTR_GENERATION,
+
+	NL802154_ATTR_SUPPORTED_COMMANDS,
+
+	NL802154_ATTR_WPAN_DEV,
+
+	/* add attributes here, update the policy in nl802154.c */
+
+	__NL802154_ATTR_AFTER_LAST,
+	NL802154_ATTR_MAX = __NL802154_ATTR_AFTER_LAST - 1
+};
+
+enum nl802154_iftype {
+	NL802154_IFTYPE_UNSPEC = -1,
+
+	NL802154_IFTYPE_NODE,
+	NL802154_IFTYPE_MONITOR,
+	NL802154_IFTYPE_COORD,
+
+	/* keep last */
+	NUM_NL802154_IFTYPES,
+	NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
+};
+
+#endif /* NL802154_H */
diff --git a/src/sections.c b/src/sections.c
new file mode 100644
index 0000000..40fdc94
--- /dev/null
+++ b/src/sections.c
@@ -0,0 +1,4 @@
+#include "iwpan.h"
+
+SECTION(get);
+SECTION(set);
-- 
2.0.4

