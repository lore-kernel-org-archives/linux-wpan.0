Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:44443 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbdJTKWl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:41 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 1/7] shared/io: Add io_recv
Date: Fri, 20 Oct 2017 13:22:30 +0300
Message-Id: <20171020102236.17499-2-luiz.dentz@gmail.com>
In-Reply-To: <20171020102236.17499-1-luiz.dentz@gmail.com>
References: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds io_recv for reading using different buffer pointed by iovec.
---
 src/shared/io-glib.c | 20 ++++++++++++++++++++
 src/shared/io.h      |  1 +
 2 files changed, 21 insertions(+)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 6687a6b28..3ea68ac4e 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -280,6 +280,26 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 	return ret;
 }
 
+ssize_t io_recv(struct io *io, const struct iovec *iov, int iovcnt)
+{
+	int fd;
+	ssize_t ret;
+
+	if (!io || !io->channel)
+		return -ENOTCONN;
+
+	fd = io_get_fd(io);
+
+	do {
+		ret = readv(fd, iov, iovcnt);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
 bool io_shutdown(struct io *io)
 {
 	if (!io || !io->channel)
diff --git a/src/shared/io.h b/src/shared/io.h
index 8bc1111d0..14f0034cf 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -35,6 +35,7 @@ int io_get_fd(struct io *io);
 bool io_set_close_on_destroy(struct io *io, bool do_close);
 
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt);
+ssize_t io_recv(struct io *io, const struct iovec *iov, int iovcnt);
 bool io_shutdown(struct io *io);
 
 typedef bool (*io_callback_func_t)(struct io *io, void *user_data);
-- 
2.13.6

