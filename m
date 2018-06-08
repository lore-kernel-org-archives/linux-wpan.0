Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:52818 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeFHRfG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Jun 2018 13:35:06 -0400
Received: by mail-it0-f52.google.com with SMTP id m194-v6so3316603itg.2
        for <linux-wpan@vger.kernel.org>; Fri, 08 Jun 2018 10:35:05 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:34:55 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: netdevice notifier and device private data
Message-ID: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hey netdev community,

I am trying to solve some issue which Eric Dumazet points to me by
commit ca0edb131bdf ("ieee802154: 6lowpan: fix possible NULL deref in
lowpan_device_event()").

The issue is that dev->type can be changed during runtime. We don't have
any problems with the netdevice notifier which Eric Dumazet fixed. I am
bother with another netdevice notifier which is broken because the same
tun/tap feature and I don't have any dev->$SUBSYSTEM_DEV_POINTER to check
if this is my netdevice type.

This netdevice notifier will access the dev->priv area which is only
available for the dev->type which was allocated and initialized with the
right dev->priv room. If a tap/tun netdevice changed their dev->type I
might have an illegal read of netdev->priv and I can't confirm that it
has the data which I cast to it. The reason for that is that tap/tun
netdevices doesn't run my netdevice init.

I already see code outside who changed tun netdevice to the
ARPHRD_6LOWPAN type and I suppose they running into this issue.
(Btw: I don't know why somebody wants to changed that type to
ARPHRD_6LOWPAN on tun).

My question is:

How we deal with that? Is it forbidden to access dev->priv from a
global netdevice notifier which only checks for dev->type?

I could solve it like Eric Dumazet and introduce a special
dev->$SUBSYSTEM_DEV_POINTER and check on it if set. At least tun/tap
will not set these pointers, then I am sure the netdevice was running
through my init function. Seems for me the best solution right now and
I think I will go for it.

I assumed before the data of dev->priv is binded to dev->type.
This tun/tap feature will break at least my handling and I am not sure
if there are others users which using dev->priv in netdevice notifier
and don't check on dev->$SUBSYSTEM_DEV_POINTER if they have one.

Thanks for everybody in advance to solve this issue.

- Alex
