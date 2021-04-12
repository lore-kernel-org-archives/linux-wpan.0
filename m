Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470ACC43460
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A17613AC
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhDLQ0A (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243692AbhDLQYm (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF74161367;
        Mon, 12 Apr 2021 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244664;
        bh=cpZE2tZXcu/4oVkhr39OZMRk74o9l8Lp8DKvAfAS6ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4VULhvgIgk7fbOHhZEOw6+dxCEeMb5jebj1EGvC6kElJxMcVJlv6XN3NyU9UYFE6
         bZHep+zB3+uStw+7O6e94tQcRQLhXUwqgsoQvqgo7Na/zhUX2GyVTCD6/x/9IcFyiW
         0UT1k6Kuc8hFOV5DCuruPkTiaE8LMKHJ45isVCNbYLpLNe+LRvRju9Dk9eyW9L0MAg
         VTDR4G9kv5FoisgIH7ljrn/P2XMXX7HpB+COU0zcwu5/3hi7KRjPUX+5hJiRakurzA
         xN3mKJkXxxcXWvJiQo255B4XRTjpoMg3BBh+ZwcLuUDuqTwj6MuAjH7lWMgkv7vafG
         wYolx+Vp/Vmuw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+28a246747e0a465127f3@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/46] drivers: net: fix memory leak in atusb_probe
Date:   Mon, 12 Apr 2021 12:23:33 -0400
Message-Id: <20210412162401.314035-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162401.314035-1-sashal@kernel.org>
References: <20210412162401.314035-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

[ Upstream commit 6b9fbe16955152626557ec6f439f3407b7769941 ]

syzbot reported memory leak in atusb_probe()[1].
The problem was in atusb_alloc_urbs().
Since urb is anchored, we need to release the reference
to correctly free the urb

backtrace:
    [<ffffffff82ba0466>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82ba0466>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<ffffffff82ad3888>] atusb_alloc_urbs drivers/net/ieee802154/atusb.c:362 [inline][2]
    [<ffffffff82ad3888>] atusb_probe+0x158/0x820 drivers/net/ieee802154/atusb.c:1038 [1]

Reported-by: syzbot+28a246747e0a465127f3@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/atusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 0dd0ba915ab9..23ee0b14cbfa 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -365,6 +365,7 @@ static int atusb_alloc_urbs(struct atusb *atusb, int n)
 			return -ENOMEM;
 		}
 		usb_anchor_urb(urb, &atusb->idle_urbs);
+		usb_free_urb(urb);
 		n--;
 	}
 	return 0;
-- 
2.30.2

