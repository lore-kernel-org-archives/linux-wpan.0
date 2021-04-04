Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CABAC433ED
	for <linux-wpan@archiver.kernel.org>; Sun,  4 Apr 2021 04:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2C561002
	for <linux-wpan@archiver.kernel.org>; Sun,  4 Apr 2021 04:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhDDE5X (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Apr 2021 00:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhDDE5X (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Apr 2021 00:57:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B837C061756
        for <linux-wpan@vger.kernel.org>; Sat,  3 Apr 2021 21:57:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s21so4503578pjq.1
        for <linux-wpan@vger.kernel.org>; Sat, 03 Apr 2021 21:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wePQzm+fjHwIolbQ+55diGyg4mHT6kViQ0QEVhszlY=;
        b=ei4/vejrSnAjUxIlTxPVkg0WrxHoQ5U9aScBlTx3qfmgyWwiWpUVeNTw2EeiCB5VmT
         xBsHmOmr53OifwsFgFFMz9DjVT2TLs6Af1ghYIeqb2UvEgMuYpU2Y6M4gSzS5WGofIwe
         w3ZplM+b3m7Q2hA1AsOkQKntQ7yYVWE2zgeSuErKB33gzKEhmIqeZ0Fx8DDaVQ0yLguL
         /hsmgoYxRARZ84a4kdytNm1+EsWNXW2sFutISC2FgPyPTMZcIwr8hC89YxKIbu9LBXIm
         4AtMFwj3uEmbN0HL8Xy67aw7A+kuvxwDqpfMRF48feac5pcPfvwBlDJ1+2Aqm76LM87u
         /puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wePQzm+fjHwIolbQ+55diGyg4mHT6kViQ0QEVhszlY=;
        b=U9uIOqooW+qAjtrug5M2HIas24bYaQMx6q/nqNndIDp1DDRZQEWyE15VNtexGvzvWw
         QZK9XjUVIcBXJGsodQWr2aEiIom03Ykv2JzRYDoE0mJT+yay30qNA9iDMVWbKy1bwpNn
         7y5Bm3xjkUBYfVtY9PnH+Py9zXXOpHkCGTrD/qNyACT9Y/7Gpy6dGnGySlVDJUbDp+2C
         qC9fKcc5ALLzronsQct2ztUy+hThZu78s3TYWIyCbOsfMK2oYpTEVxlSb7xhg4rWvYzk
         hSx4hyyq8hxVMBn/HpVLEw/C1Pt99D/LhmpZ1x9eUX1My9aTC3RpHwJny++rvJ63GuvR
         g7SQ==
X-Gm-Message-State: AOAM53125Xz6aXmRl2+ooG4w06weev7G7w/gGEn5PDrISDaY0Gd/TiUH
        FkHZjKHulnzBhDMjz54/GLE=
X-Google-Smtp-Source: ABdhPJxlCsF6yOg9WXBnLo1XFuwOqFX7AwibiW/DwhGBlVoMAIcmS3sATbb8Gvc/oB6l1h/5bNXb/A==
X-Received: by 2002:a17:90a:5d14:: with SMTP id s20mr21004578pji.6.1617512237558;
        Sat, 03 Apr 2021 21:57:17 -0700 (PDT)
Received: from nuc.c.rabbit-hole-integration-007.internal ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id w23sm12230872pgi.63.2021.04.03.21.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 21:57:17 -0700 (PDT)
From:   Du Cheng <ducheng2@gmail.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org, Du Cheng <ducheng2@gmail.com>,
        syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Subject: [PATCH] net:mac802154: add init of .sec and .sec_mtx for sdata in ieee802154_setup_sdata
Date:   Sun,  4 Apr 2021 12:57:12 +0800
Message-Id: <20210404045712.50954-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

add mutex_init(&sdata->sec_mtx) and mac802154_llsec_init(&sdata->sec) for
NL802154_IFTYPE_MONITOR inside ieee802154_setup_sdata. As the unintiated
mutex and sec data structure were used in ieee802154_get_llsec_params
which would cause a kernel crash. BUG reported by syzkaller.

Reported-by: syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
---
link to syzkaller bug:
https://syzkaller.appspot.com/bug?id=a9cc0c65e7bb15be7143107d4215ebc8ef047528
This patch has passed syzbot testing.

 net/mac802154/iface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 1cf5ac09edcb..bec903e98db0 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -602,6 +602,9 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->needs_free_netdev = true;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
 		wpan_dev->promiscuous_mode = true;
+
+		mutex_init(&sdata->sec_mtx);
+		mac802154_llsec_init(&sdata->sec);
 		break;
 	default:
 		BUG();
-- 
2.30.2

