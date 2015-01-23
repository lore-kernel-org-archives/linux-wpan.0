Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46944 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbbAWI3m (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Jan 2015 03:29:42 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so7239482pdj.7
        for <linux-wpan@vger.kernel.org>; Fri, 23 Jan 2015 00:29:41 -0800 (PST)
Received: from cdac.hyderabad.cdac.in ([196.12.45.164])
        by mx.google.com with ESMTPSA id i4sm1122761pdl.11.2015.01.23.00.29.39
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 00:29:40 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-misc] website: fix name for Table:2
Date: Fri, 23 Jan 2015 13:55:26 +0530
Message-Id: <1422001526-14559-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 website/index.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 4ccb218..c9e58d2 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -116,7 +116,7 @@ Currently a rework of 802.15.4 subsystem is in progress.
 
 The rework will contains a new netlink API and a general handling about frame creation and parsing.
 
-.Supported 802.15.4 Hardware
+.Work status
 [options="header"]
 |=======================================
 |Milestone        | Description | state
-- 
1.7.9.5

