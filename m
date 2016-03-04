Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60364 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759018AbcCDJK3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 04:10:29 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 2/2] 6lowpan: debugfs: add missing static
Date: Fri,  4 Mar 2016 10:10:21 +0100
Message-Id: <1457082621-20194-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1457082621-20194-1-git-send-email-aar@pengutronix.de>
References: <1457082621-20194-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch solves the sparse warning:

net/6lowpan/debugfs.c:164:30: warning: symbol 'lowpan_ctx_pfx_fops' was
not declared. Should it be static?
net/6lowpan/debugfs.c:241:30: warning: symbol 'lowpan_context_fops' was
not declared. Should it be static?

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index aa49ff4..0793a81 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -161,7 +161,7 @@ out:
 	return status;
 }
 
-const struct file_operations lowpan_ctx_pfx_fops = {
+static const struct file_operations lowpan_ctx_pfx_fops = {
 	.open		= lowpan_ctx_pfx_open,
 	.read		= seq_read,
 	.write		= lowpan_ctx_pfx_write,
@@ -238,7 +238,7 @@ static int lowpan_context_open(struct inode *inode, struct file *file)
 	return single_open(file, lowpan_context_show, inode->i_private);
 }
 
-const struct file_operations lowpan_context_fops = {
+static const struct file_operations lowpan_context_fops = {
 	.open		= lowpan_context_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-- 
2.7.2

