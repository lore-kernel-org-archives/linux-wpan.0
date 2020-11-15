Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526F3C2D0E4
	for <linux-wpan@archiver.kernel.org>; Sun, 15 Nov 2020 10:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0906A2244C
	for <linux-wpan@archiver.kernel.org>; Sun, 15 Nov 2020 10:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQrq0ITA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKOK1X (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 15 Nov 2020 05:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgKOK1W (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 15 Nov 2020 05:27:22 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80151C0613D1;
        Sun, 15 Nov 2020 02:27:22 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so678565pgb.4;
        Sun, 15 Nov 2020 02:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rMHvhhCmzGV9BISyaqavP076DKPv4LbP5/GgC+7100M=;
        b=fQrq0ITAskjPmYBsKXipLYR+elBVHv30YNSVWbS/5Ez+mKlBCTsTBtWWJGZBqZd47t
         Eu4vfptam1ag5tdtTLztsaJjNj/x2UBxPuXmNWODJ3dVU8crkR60AN7UxmjvHQ+fRfa8
         Lb2WwEWEdsBmqaXgob2x8QrOr/7FjfMFlIDeH79Azp0zdpLC7deSYcJZYlvWCAGB+8/0
         u16ApGgpqntEEye5M1WoL2TpQl9b8SEZCE5mP50PsBGak4bM4Q9yGAL6TGZuyBsGiAeg
         mBmqo403L48IH26OTJZ6fCUl7G82QR1laun547ddOBJGWQ6szCQSKuaKuchkyLhBnKi8
         /K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rMHvhhCmzGV9BISyaqavP076DKPv4LbP5/GgC+7100M=;
        b=lIrVMnT0a8jTGbdtnILNKE0xWXGs8/6RKsIVSknO2KY2/HiyQRImsRNUuU4+MfysFg
         m4HYFZeMZjjFqpjg6Oo4NooncrPLHW1gOzK1Kdx8t5S0bL2sm3648ItjQNB1tfnYUzZj
         aDLL685RKk7kc4GTWjzAF1urzwDzzVYIHtazhNxrBGSVTmXhD6AlO9kiO/3DG6z0I73O
         LaIBtMjH6VmjoAa5leSbBDGv6fwnS93L/YhdGkQRU53+s9250zJ949atAlb98nWGxhu+
         xqwywQyr1c0Vr6Xgr5lRSkpNRrSdQXXBNjmHmdVMT+eqHUnj7aABWAx7xnTOXdFGCtUa
         65qA==
X-Gm-Message-State: AOAM530Op/ZVK+pucMJy626yDTOsrVeXKdTXznGqolibXm/3OaYMpHK4
        bD1/Lux+smC2tW5v7sajcQO9xwu+Gzs=
X-Google-Smtp-Source: ABdhPJxJ3nX0S9cyu+NF375zhDK8QY1W+TKLGnKX6lNVRJSbjl2ZbORa0PSVNVJNGGGKgPrJV6PrRw==
X-Received: by 2002:a62:de44:0:b029:18a:ae59:4d74 with SMTP id h65-20020a62de440000b029018aae594d74mr9225816pfg.72.1605436042033;
        Sun, 15 Nov 2020 02:27:22 -0800 (PST)
Received: from localhost.localdomain ([49.173.165.44])
        by smtp.gmail.com with ESMTPSA id j1sm7211117pji.22.2020.11.15.02.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 02:27:21 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     alex.aring@gmail.com, jukka.rissanen@linux.intel.com,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH v3 net] 6lowpan: set .owner to THIS_MODULE
Date:   Sun, 15 Nov 2020 10:27:14 +0000
Message-Id: <20201115102714.30412-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

If THIS_MODULE is not set, the module would be removed while debugfs is
being used.
It eventually makes kernel panic.

Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Separate from one big series

v2:
 - Change headline
 - Squash patches into per-driver/subsystem

 net/6lowpan/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 1c140af06d52..2f791ccc783b 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -161,6 +161,7 @@ static const struct file_operations lowpan_ctx_pfx_fops = {
 	.write		= lowpan_ctx_pfx_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
+	.owner          = THIS_MODULE,
 };
 
 static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
-- 
2.17.1

