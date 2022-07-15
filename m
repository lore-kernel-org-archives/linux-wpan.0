Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B60BC433EF
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Jul 2022 13:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiGRNK2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiGRNK1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Jul 2022 09:10:27 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60591A83D;
        Mon, 18 Jul 2022 06:10:22 -0700 (PDT)
X-QQ-mid: bizesmtp62t1658149787tw0f4uoy
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:09:45 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: 9E3Ddn8eo0Kg1vsX00lVxwqcMqmpmrPNqX0bOG/HAXdvLjFwsTqMSEKYHp1cy
        bRSS4KWsRN3thTAaOjI8whAJGkfp6aaUlNzUOEJET4Hv+D8B/YBquEA/DbZo4aWapTQWxoT
        xyF/9P7QDmL2Q2Soexnaksx+lCe7wlKMJCaJrkyrvBJTpBVlUQ7fq7mVatOcz9xLf24ALfp
        ePzLejSPOT18WQnU5SAt9O8lxbh5wDatrf9uRpFK0H4IMxxvSNC54zsqcOVF3NaiAOPl2PJ
        Xa/rSAl2pQqsTU03MnBZl0yvUaEHOde1nJkUTOA+6wHeLsJ27a/Q70aYpERELoDxkYFcZye
        PwfTGSQxdJPkoHJ9vjioKdun50zxgCPyiPdqRoHzBYVRI92/lfhQtkuzpYfWQvFpJhNHWT3
        tcjU/Vxw/1/EJF63N9O2QA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     stefan@datenfreihafen.org
Cc:     alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] net: ieee802154: ca8210: Fix comment typo
Date:   Fri, 15 Jul 2022 13:07:48 +0800
Message-Id: <20220715050748.27161-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The double `was' is duplicated in line 2296, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 42c0b451088d..450b16ad40a4 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2293,7 +2293,7 @@ static int ca8210_set_csma_params(
  * @retries:  Number of retries
  *
  * Sets the number of times to retry a transmission if no acknowledgment was
- * was received from the other end when one was requested.
+ * received from the other end when one was requested.
  *
  * Return: 0 or linux error code
  */
-- 
2.35.1

