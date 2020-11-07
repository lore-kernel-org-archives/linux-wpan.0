Return-Path: <SRS0=Tztn=EN=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD71C388F7
	for <linux-wpan@archiver.kernel.org>; Sat,  7 Nov 2020 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA20220878
	for <linux-wpan@archiver.kernel.org>; Sat,  7 Nov 2020 17:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8pGdy/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKGRZd (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 7 Nov 2020 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgKGRZd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 7 Nov 2020 12:25:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDFC0613CF;
        Sat,  7 Nov 2020 09:25:33 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j5so2465469plk.7;
        Sat, 07 Nov 2020 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2amA39ppsr3LBtIjpr5PbVmxsb95/8j5ztb5/6gLDc0=;
        b=j8pGdy/Y2XkRDXAOXTkI8sHNer4xWEnPjNxc9eJ90idf+pukg+I7NSMKtLsrZY2NWt
         pPd7X05CykbW3lgXeLpiORiEdXY/6Zn7ixE9xx1RNtr3VLBZgxGYEsa6zO7kFX1iixam
         z5WY8kgdycrE5BggnMTBaGO4tn/wh6b7p99Mw8enfrTFlcPa9UDJe89ATVrPPePnaB7y
         7F+Xff8kxKrFrUjTNF3rDtHGcD5I5LWktz0Vve6yo07IGr6Bd1C94cIcXDYUz19SEnah
         3WiX5VERWHLFDt4z/U4pfjxXC6wrWedR3vo0Ax3GsqvJgf7X7+vWORt09+erGAoRVTbu
         0wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2amA39ppsr3LBtIjpr5PbVmxsb95/8j5ztb5/6gLDc0=;
        b=niNMeM8rRMzvbqEpSTEgIzUHpiwbUTsffMH1euE1j6dx4WAgPicTwI5Kseh+wJa8ad
         HgA2HsnVROMz6kjN4q9bQE1b7gYZs3HIvAQAgtq6qVfoHsyEl/B/0wYmU3FtUfacDWZ5
         V+ejmXgBVdPx8IZq1B1apfjO8ueg+AN3YxbY5bEFfK4bKirkwdmkK5c2KZrLW+mQeur0
         BMJ37svLKRtaNRTwDZJwmcSzwChBzgWMLPFgEsj0F/x9eFeUnLt5v8gABeZb8AP3m2Bi
         gaNANSLK6+TQHso4PLCxWzQVU7u7khchHtsMhOOHZeNqsZtYJXrSQg0fjwDnMSB8wV/T
         y9GQ==
X-Gm-Message-State: AOAM533obQPfrlCgS1fqluGsxtLveuESg7QJKuzw2WACkQNV4PFIxkhO
        9o9zo4+EQ/VzFmaX2R+znZ0=
X-Google-Smtp-Source: ABdhPJyOR4vW9Ms8W+c4vkQRPUgt3FHemCkVq5jeFZzT3s/0hsrAV6aPm9e8Mt3iWhVgfT+bVdpW1w==
X-Received: by 2002:a17:90a:7d06:: with SMTP id g6mr4912750pjl.113.1604769932699;
        Sat, 07 Nov 2020 09:25:32 -0800 (PST)
Received: from localhost.localdomain ([180.70.143.152])
        by smtp.gmail.com with ESMTPSA id m17sm4916962pgu.21.2020.11.07.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 09:25:31 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Cc:     ap420073@gmail.com, David.Laight@aculab.com,
        johannes@sipsolutions.net, nstange@suse.de, derosier@gmail.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, b43-dev@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, michael.hennerich@analog.com,
        linux-wpan@vger.kernel.org, stefan@datenfreihafen.org,
        inaky.perez-gonzalez@intel.com, linux-wimax@intel.com,
        emmanuel.grumbach@intel.com, luciano.coelho@intel.com,
        stf_xl@wp.pl, pkshih@realtek.com, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, wcn36xx@lists.infradead.org,
        merez@codeaurora.org, pizza@shaftnet.org,
        Larry.Finger@lwfinger.net, amitkarwar@gmail.com,
        ganapathi.bhat@nxp.com, huxinming820@gmail.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, alex.aring@gmail.com,
        jukka.rissanen@linux.intel.com, arend.vanspriel@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chung-hsien.hsu@infineon.com, wright.feng@infineon.com,
        chi-hsien.lin@infineon.com
Subject: [PATCH net v2 19/21] b43: set .owner to THIS_MODULE
Date:   Sat,  7 Nov 2020 17:21:50 +0000
Message-Id: <20201107172152.828-20-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201107172152.828-1-ap420073@gmail.com>
References: <20201107172152.828-1-ap420073@gmail.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

If THIS_MODULE is not set, the module would be removed while debugfs is
being used.
It eventually makes kernel panic.

Fixes: e4d6b7951812 ("[B43]: add mac80211-based driver for modern BCM43xx devices")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v1 -> v2:
 - Change headline

 drivers/net/wireless/broadcom/b43/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/b43/debugfs.c b/drivers/net/wireless/broadcom/b43/debugfs.c
index 89a25aefb327..c0d51cb57b27 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -611,6 +611,7 @@ static ssize_t b43_debugfs_write(struct file *file,
 			.read	= b43_debugfs_read,		\
 			.write	= b43_debugfs_write,		\
 			.llseek = generic_file_llseek,		\
+			.owner = THIS_MODULE,			\
 		},						\
 		.file_struct_offset = offsetof(struct b43_dfsentry, \
 					       file_##name),	\
-- 
2.17.1

