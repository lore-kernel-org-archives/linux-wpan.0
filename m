Return-Path: <SRS0=PnyL=EI=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45557C00A89
	for <linux-wpan@archiver.kernel.org>; Mon,  2 Nov 2020 11:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E354221D91
	for <linux-wpan@archiver.kernel.org>; Mon,  2 Nov 2020 11:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6Fp50ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgKBLsM (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgKBLpw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Nov 2020 06:45:52 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F72C0617A6
        for <linux-wpan@vger.kernel.org>; Mon,  2 Nov 2020 03:45:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w1so14240626wrm.4
        for <linux-wpan@vger.kernel.org>; Mon, 02 Nov 2020 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWgM+9wLuX8CxFAK18XYYejQxSRrdtsxUWktHkjPbDM=;
        b=E6Fp50ulPAfuAJ6P5gCUm0zVao8mKSzXvbeCmHfykPE1YvpvDyXsSz+Q2Gl3X25pgS
         cIphkuRccC94rwEIfwRbgic+6QEQysrjw+3g6OV95uygyBShSSXVKixSsgLvIK+dD+RY
         JpQCTEjNt49VEK43k+g+1S+knd0zPP5GfGt82z1CG8WsIzEaMYIiL5ioSD2LOajWViEA
         QUIe3imS+ofT2HZKN+TvNazJt1XTQZBYh7Zrgmf6m5+vj73MVctzPfGK49IfyZOy5SDk
         bBkpri/Ulz7dh5vV0yRW7MFPkfmZk3X9tcAB5IoRFUUwoI1hLXZa55J72xKZxxy4Xso/
         di0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWgM+9wLuX8CxFAK18XYYejQxSRrdtsxUWktHkjPbDM=;
        b=OfA4sO+1fDVo+/7v28E8rd3Z2/WLT+Cggsu+R6Qy9RW5TgVCoGBZF4LqDEOqI03Z3S
         iJdjLl2XD8co3cq2O3tWzNWF/oITM6VQYqHLtrZj4J8zdhTrRtAS3yEF14PUJtbskhPj
         fYnc1aILgYSnAvHSpAklcCBfq30ORokKD/FWGtv2U50V1bMU+KyBQ8bVbzlQuoCX0b6O
         zA9Dq0PpDY5NAWkF9blKKGfMXestwA0mU+1TSDcYqn8huDqut0HlMaELQlDjJWaLETfv
         W6jJqjJhI/8Cmc7/CWjx2mBUHH/97mEgsda6taimezQBJboUBe0Seha+x4rkLmlOcDnI
         I8CA==
X-Gm-Message-State: AOAM532lDRz+WvuIenl5KlAHtMWR5/z1acXAgjsylvMoWNCJfIuY3VNI
        qFyEpHF7ll+9YB8XxBHTW79S3A==
X-Google-Smtp-Source: ABdhPJyqxRoQANg1UUIJRw+oLBLo0MjxqNAIVuiK5NQIfLgVEVOm2KJ+pjSQEIrBSK1gdgEudWq9WQ==
X-Received: by 2002:adf:e849:: with SMTP id d9mr21045411wrn.25.1604317543902;
        Mon, 02 Nov 2020 03:45:43 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id g66sm15545352wmg.37.2020.11.02.03.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:45:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net
Cc:     Lee Jones <lee.jones@linaro.org>,
        Harry Morris <h.morris@cascoda.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 20/30] net: ieee802154: ca8210: Fix a bunch of kernel-doc issues
Date:   Mon,  2 Nov 2020 11:45:02 +0000
Message-Id: <20201102114512.1062724-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102114512.1062724-1-lee.jones@linaro.org>
References: <20201102114512.1062724-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ieee802154/ca8210.c:326: warning: Function parameter or member 'readq' not described in 'ca8210_test'
 drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'spi_transfer_complete' not described in 'ca8210_priv'
 drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'sync_exchange_complete' not described in 'ca8210_priv'
 drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'promiscuous' not described in 'ca8210_priv'
 drivers/net/ieee802154/ca8210.c:430: warning: Function parameter or member 'short_address' not described in 'macaddr'
 drivers/net/ieee802154/ca8210.c:723: warning: Function parameter or member 'cas_ctl' not described in 'ca8210_rx_done'
 drivers/net/ieee802154/ca8210.c:723: warning: Excess function parameter 'arg' description in 'ca8210_rx_done'
 drivers/net/ieee802154/ca8210.c:1289: warning: Excess function parameter 'device_ref' description in 'tdme_checkpibattribute'
 drivers/net/ieee802154/ca8210.c:3054: warning: Function parameter or member 'spi_device' not described in 'ca8210_remove'
 drivers/net/ieee802154/ca8210.c:3054: warning: Excess function parameter 'priv' description in 'ca8210_remove'
 drivers/net/ieee802154/ca8210.c:3104: warning: Function parameter or member 'spi_device' not described in 'ca8210_probe'
 drivers/net/ieee802154/ca8210.c:3104: warning: Excess function parameter 'priv' description in 'ca8210_probe'

Cc: Harry Morris <h.morris@cascoda.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ieee802154/ca8210.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 4eb64709d44cb..9b3ab7acad37e 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -316,6 +316,7 @@ struct cas_control {
  * struct ca8210_test - ca8210 test interface structure
  * @ca8210_dfs_spi_int: pointer to the entry in the debug fs for this device
  * @up_fifo:            fifo for upstream messages
+ * @readq:              read wait queue
  *
  * This structure stores all the data pertaining to the debug interface
  */
@@ -346,12 +347,12 @@ struct ca8210_test {
  * @ca8210_is_awake:        nonzero if ca8210 is initialised, ready for comms
  * @sync_down:              counts number of downstream synchronous commands
  * @sync_up:                counts number of upstream synchronous commands
- * @spi_transfer_complete   completion object for a single spi_transfer
- * @sync_exchange_complete  completion object for a complete synchronous API
- *                           exchange
- * @promiscuous             whether the ca8210 is in promiscuous mode or not
+ * @spi_transfer_complete:  completion object for a single spi_transfer
+ * @sync_exchange_complete: completion object for a complete synchronous API
+ *                          exchange
+ * @promiscuous:            whether the ca8210 is in promiscuous mode or not
  * @retries:                records how many times the current pending spi
- *                           transfer has been retried
+ *                          transfer has been retried
  */
 struct ca8210_priv {
 	struct spi_device *spi;
@@ -420,8 +421,8 @@ struct fulladdr {
 
 /**
  * union macaddr: generic MAC address container
- * @short_addr:   16-bit short address
- * @ieee_address: 64-bit extended address as LE byte array
+ * @short_address: 16-bit short address
+ * @ieee_address:  64-bit extended address as LE byte array
  *
  */
 union macaddr {
@@ -714,7 +715,7 @@ static void ca8210_mlme_reset_worker(struct work_struct *work)
 /**
  * ca8210_rx_done() - Calls various message dispatches responding to a received
  *                    command
- * @arg:  Pointer to the cas_control object for the relevant spi transfer
+ * @cas_ctrl: Pointer to the cas_control object for the relevant spi transfer
  *
  * Presents a received SAP command from the ca8210 to the Cascoda EVBME, test
  * interface and network driver.
@@ -1277,7 +1278,6 @@ static u8 tdme_channelinit(u8 channel, void *device_ref)
  * @pib_attribute:        Attribute Number
  * @pib_attribute_length: Attribute length
  * @pib_attribute_value:  Pointer to Attribute Value
- * @device_ref:           Nondescript pointer to target device
  *
  * Return: 802.15.4 status code of checks
  */
@@ -3046,7 +3046,7 @@ static void ca8210_test_interface_clear(struct ca8210_priv *priv)
 
 /**
  * ca8210_remove() - Shut down a ca8210 upon being disconnected
- * @priv:  Pointer to private data structure
+ * @spi_device:  Pointer to spi device data structure
  *
  * Return: 0 or linux error code
  */
@@ -3096,7 +3096,7 @@ static int ca8210_remove(struct spi_device *spi_device)
 
 /**
  * ca8210_probe() - Set up a connected ca8210 upon being detected by the system
- * @priv:  Pointer to private data structure
+ * @spi_device:  Pointer to spi device data structure
  *
  * Return: 0 or linux error code
  */
-- 
2.25.1

