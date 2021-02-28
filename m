Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C73C433E0
	for <linux-wpan@archiver.kernel.org>; Sun, 28 Feb 2021 15:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F394E64EAF
	for <linux-wpan@archiver.kernel.org>; Sun, 28 Feb 2021 15:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhB1PTx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 28 Feb 2021 10:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhB1PTv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 28 Feb 2021 10:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614525505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HfFehcOsqtX+wrGXe9KHlX5UwuAFL9RxpxTjDgN0seU=;
        b=KzkZ3wJ+E/gt9twcBEWcGh6oST5luLQrPzKGEE+XY/uvTY/sRAgFdjyuegQRaQ3KgUo9X0
        jKD20VObL6ojC+ZajhNZ8CU3+4Cx0l8ipE4ns2c680Q3o7sWyHiZv1/G5u2ov/7GPbDsz2
        cPcpTeeGNZzcCDOUDts/gd9eF1ELenk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-r7T1VvNEPkS_Ksj3oEg3dg-1; Sun, 28 Feb 2021 10:18:23 -0500
X-MC-Unique: r7T1VvNEPkS_Ksj3oEg3dg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2B0B107ACE3;
        Sun, 28 Feb 2021 15:18:21 +0000 (UTC)
Received: from carbon.redhat.com (ovpn-112-225.rdu2.redhat.com [10.10.112.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D18F5C1D5;
        Sun, 28 Feb 2021 15:18:21 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH wpan 00/17] ieee802154: syzbot fixes
Date:   Sun, 28 Feb 2021 10:18:00 -0500
Message-Id: <20210228151817.95700-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

this patch series contains fixes found by syzbot for nl802154 and a
memory leak each time we receiving a skb for monitor interfaces.

The first three patches are misc fixes, all others are to forbid monitor
interfaces to access security mib values which are never initialized for
monitor interfaces yet. We never supported such handling but I can
imagine that we can use security mib for monitor interfaces to decrypt
802.15.4 frames by the Linux kernel and the RAW sockets can see
plaintext then. However it's a possibility for an new feature to check in
due courses.

- Alex

Alexander Aring (17):
  net: ieee802154: make shift exponent unsigned
  net: ieee802154: fix memory leak when deliver monitor skbs
  net: ieee802154: nl-mac: fix check on panid
  net: ieee802154: forbid monitor for set llsec params
  net: ieee802154: stop dump llsec keys for monitors
  net: ieee802154: forbid monitor for add llsec key
  net: ieee802154: forbid monitor for del llsec key
  net: ieee802154: stop dump llsec devs for monitors
  net: ieee802154: forbid monitor for add llsec dev
  net: ieee802154: forbid monitor for del llsec dev
  net: ieee802154: stop dump llsec devkeys for monitors
  net: ieee802154: forbid monitor for add llsec devkey
  net: ieee802154: forbid monitor for del llsec devkey
  net: ieee802154: stop dump llsec seclevels for monitors
  net: ieee802154: forbid monitor for add llsec seclevel
  net: ieee802154: forbid monitor for del llsec seclevel
  net: ieee802154: stop dump llsec params for monitors

 net/ieee802154/nl-mac.c   |  7 ++---
 net/ieee802154/nl802154.c | 54 ++++++++++++++++++++++++++++++++++++++-
 net/mac802154/rx.c        |  2 ++
 3 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.26.2

