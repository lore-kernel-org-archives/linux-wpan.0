Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:64357 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbaHLIQ4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 04:16:56 -0400
Received: by mail-la0-f44.google.com with SMTP id el20so6671326lab.3
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 01:16:54 -0700 (PDT)
Received: from omega (p20030064A9351216E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a935:1216:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id e7sm7393590lae.9.2014.08.12.01.16.53
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2014 01:16:53 -0700 (PDT)
Date: Tue, 12 Aug 2014 10:16:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140812081646.GA8032@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: New direction of the 802.15.4 implementation
To: linux-wpan@vger.kernel.org

Hi,

This is some note about the new possible direction of this stack
implementation.

The current implementation have several issues, maybe you notice these.

1. Non working monitor device (I get it working with some hacks)

2. There are some mlme ops which don't have any functionality like PAN
   coordinator functionality.(association, ...)

3. Workqueues (Have lot of overhead, should be removed)

4. No async xmit callbacks

5. Slave list need more robust. (No different channels on the slaves,
   like wireless)

6. Make structs like IEEE 802.15.4 standard, I mean the MAC PIB and PHY
   PIB, etc.. sometimes I read the name but when I see the structs it
   isn't that what the standard shows.



I take a closer look at the wireless implementation and this is what we
also should use as a good example. We should all things name like the wireless
stack, so people which comes from this implementation can easly
integrate into the 802.15.4 implementation. This sounds hard but this
was already done, the mac802154_priv struct is the ieee80211_local
struct, etc... we have lot of similarity there. (A note about the priv
struct, we have too much privs in the implementation ipriv, priv I
getting crazy because this.)

They have a lot of ieee80211_* struct, we should name our structs ieee802154_*.
Maybe we can take a more closer look and merge things together, but this
is something for the future.

Currently we have two slave types, these are:

- wpan
- monitor

I will drop the monitor device, because it's not working. Then I will
add:

- node
- monitor
- coord

This allow us to have at the _beginning_ a splitted kernelspace
implementation for node, monitor and coordinator devices.

The node device is similar to the wpan device. The coord device is an coordinator
device. We do this split at beginning and maybe we can merge the
coordinator functionality in the node device type. But for beginning we
split the implementation for that.



For workqueues issues:

The xmit callback will be asynchron and we introduce a xmit_sync
callback as fallback if xmit is not implemented.

The different of these xmit callbacks are that the async xmit call
doesn't block until transmit is done, this will redouce some workqueue
overhead.

We can't just drop the workqueues, because some drivers use the spi_sync
functions.




The wireless stack use slaves list not to have more virtual interfaces
on the phy of the same type. They have it more to have different device
types on a phy like node, monitor or coordinator. I think this is a big
mistake of the current stack implementation. In wireless there are
STATION, ACCESSPOINT, MESH, etc. interface types.

We should go the way exactly like the mac80211 implementation. For the
beginning we don't need gadgets like priority scheduling of frametypes,
etc. Just a base implementation like wireless with receiving and frame
parsing. etc.


For the first we have only the interface type NODE and this is like
STATION in wireless implementation. As default device this is always
set, you don't need userspace tools for that "iz add ...".

I will try to keep all the current "userful and functionality" netlink
interfaces and start also a implementation of a new userspacetool named
"wpan-tools" with iwpan as binary name (like iw wireless).

- Alex
