Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33390 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbdGLRLA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jul 2017 13:11:00 -0400
Received: by mail-wm0-f52.google.com with SMTP id t70so130039wmt.0
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jul 2017 10:10:59 -0700 (PDT)
Date: Wed, 12 Jul 2017 19:10:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: handling multiple MAC instances (multiple address filters)
Message-ID: <20170712171051.z35bk6piiqtqypwm@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: mcr@sandelman.ca

Hi,

Michael requested to handle different pan's per 6lowpan interface,
because pan's are like VLANs etc. :-)

I told that for destination pan this is possible, but source pan's are
difficult, because most hardware has only _one_ address filters.
My idea was to going into promiscuous mode and let Linux filter all the
stuff when multiple address filters are required.

Then the discussed stopped after I took a shower and realized we lost
ack handling when going into promiscuous mode... The transceiver will
simple ack every frame which it's received then if we don't stop ack
handling.

This was the last state of the idea.

Now, after I looked because RX_SAFE_MODE into af86rf2xx datasheets
again. I think we could try to do the following:

- The same idea like above, transceiver will go into promiscuous mode if
  we create multiple interfaces (MAC instances) on one phy, which allows
  to run on different source PAN on each interface.

Explain slotted mode: In slotted mode we can send an ack or not over
toggle a pin (at86rf2xxx). The sequence number will be used which is
actually inside the framebuffer. The good thing is: We don't need to do
spi stuff and skb alloc for doing that (which takes long time).

How it would look like is:

 - RX done irq comes
 - Grab buffer information
 - Doing fast a source address lookup and check if we have a mac
   interface currently running which has the address and ack is
   requested.
   - If so trigger pin to send ack.
   - If not do nothing and drop (because we are not meant)

Don't know if we can still keep all the timing stuff, but we don't need
to fiddle on our own to alloc skb and not do spi traffic for send ack
frame out. Could maybe work :-/

---

Another question is: Is running multiple interfaces on one PHY the thing
what we "need". I think yes, because the 802.15.4 spec describe only one
source PAN to operate on. Another idea would be to override src pan
setting per sendmsg(2), but it sounds weird that a wpan interface will
receive frames from two different pans and _all_ socket connection need
to filter source pans per recvmsg(2) then.

What you can simple do is to run multiple wpan interface on one PHY
(even monitor, if you want... because Linux need to filter everything)
what you want do to then is up to you and part of user space, maybe?

- Alex
