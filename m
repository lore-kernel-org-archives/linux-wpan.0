Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:46516 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaHMNqy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:46:54 -0400
Received: by mail-la0-f54.google.com with SMTP id hz20so8952885lab.41
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:46:52 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:23 +0200
Message-Id: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 00/12] ieee802154: mac802154: wireless transformation part 2
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this is the next series to make the 802.15.4 implementation like wireless.
I fixed also some issues from my previous series.

This was:

- a typo in commit ("mac802154: remove not functional monitor device")
- missing tasklet_kill(&local->tasklet) in ieee802154_unregister_hw
  ("mac802154: rx: use tasklet instead workqueue")

I created a branch for this at github, you can see this at [0].

At the end I will resubmit all patches on this mailinglist and then I will
merge this branch to master.

In this series I cleanup a little bit the rx.c file. It contains now all
parsing function from wpan.c file until netif_rx call.

Also I rework the open and close callback for the netdev interface. This
adds also a driver-ops header file like the mac80211 one. This file contains
wrapper function for calling device_ops. We should do this for all device_ops
which we call, instead doing local->ops->foobar(local->hw, ...) etc...

We are now a little bit closer to the wireless implementation style, but
it need some work to have a similar parsing function call.

Another thing is to have a similar interface/phy registration like wireless,
this need a new userspace software. I will try to create one, but this need
some time.

Also I will try to implement the perm_address, the perm_address is for an
extended address which is set by the driver. This can be a random generated
one or contains information from an eeprom. This address would be default
mac address of the registered wpan interface. At the moment our mac address
is default 00..00.


Sorry, I think we should not accept more patches for next. If you like you
can help me with the wireless transformation implementation. Simply ask
or send patches which I should apply on the "wpan_rework_rfc" branch.

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/commits/wpan_rework_rfc

Alexander Aring (12):
  mac802154: rx: warn if ieee80211_rx call from irq
  mac802154: move header parse functions to rx.c
  mac802154: rename sdata slaves and slaves_mtx
  mac802154: introduce IEEE802154_DEV_TO_SUB_IF
  mac802154: move slave open/close functions to wpan
  mac802154: rename wpan.c to iface.c
  mac802154: rx: use netif_receive_skb
  mac802154: introduce internal driver-ops header
  mac802154: remove useless -EBUSY if sdata running
  mac802154: rework open count
  mac802154: remove ieee802154_addr from driver_ops
  mac802154: rework sdata state change to running

 include/net/mac802154.h      |   1 -
 net/mac802154/Makefile       |   2 +-
 net/mac802154/driver-ops.h   |  29 +++
 net/mac802154/ieee802154_i.h |  20 +-
 net/mac802154/iface.c        | 457 +++++++++++++++++++++++++++++++++
 net/mac802154/mac_cmd.c      |   2 +-
 net/mac802154/main.c         | 114 ++-------
 net/mac802154/mib.c          |  49 ++--
 net/mac802154/rx.c           | 190 ++++++++++++++
 net/mac802154/tx.c           |   4 +-
 net/mac802154/wpan.c         | 596 -------------------------------------------
 11 files changed, 739 insertions(+), 725 deletions(-)
 create mode 100644 net/mac802154/driver-ops.h
 create mode 100644 net/mac802154/iface.c
 delete mode 100644 net/mac802154/wpan.c

-- 
2.0.3

