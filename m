Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:53288 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeFIP3d (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Jun 2018 11:29:33 -0400
Received: by mail-it0-f48.google.com with SMTP id a195-v6so5763760itd.3
        for <linux-wpan@vger.kernel.org>; Sat, 09 Jun 2018 08:29:33 -0700 (PDT)
Date: Sat, 9 Jun 2018 11:29:21 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: netdevice notifier and device private data
Message-ID: <20180609152921.hqfmprmd4ryttaie@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
 <32763.1528486664@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32763.1528486664@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 08, 2018 at 03:37:44PM -0400, Michael Richardson wrote:
> 
> Alexander Aring <aring@mojatatu.com> wrote:
>     Alex> I already see code outside who changed tun netdevice to the
>     Alex> ARPHRD_6LOWPAN type and I suppose they running into this
>     Alex> issue.  (Btw: I don't know why somebody wants to changed that
>     Alex> type to ARPHRD_6LOWPAN on tun).
> 
> so that they can have the kernel do 6lowpan processing, emitting 6lowPAN
> packets into userspace to be transfered into a radio via some proprietary
> interface (including, for instance SLIP over USB cable to Contiki or OpenWSN stack, 
> set up to act as radio only)
> 

No, the datapath doesn't change. If the user space evaluate the
dev->type (there exists some ioctl() for it) it will assume it has a
6LoWPAN type interface.

A lot of user space software outside will doing interface specific
handling after detect the type. E.g. wireshark will select some dissector
handling.

On a tun interface and switch to 6LoWPAN it will not change much the
dissector view, because both raw IPv6 packets on datapath. For me as
6LoWPAN maintainer it makes no sense to switch to it. Currently
some netdevice notifier will crash (if you a lucky it will not).

Futhermore user space programs e.g. radvd will do 6lowpan specific
handling on 6lowpan dev->type, it will not work either on tun devices.

I know that wpantund from NestLabs do this switch, I am very curious
about the reason but I think they do it because the name is 6LoWPAN. But
wpantund is just a SLIP like protocol with additional radio/foo commands.

---

According to the people who say "I like to have a 6LoWPAN tun device,
that would be nice" - I don't know how this will ever work since 6LoWPAN
header highly depends on MAC header information. Tun devices works
because IP architecture allows a separation from MAC layer. I already
saw protocols at IETF where MAC header information are needed on top of
UDP payload in case of 6LoWPAN. (I talked about that at last netdev in
Montreal).

Bluetooth wanted to add a tun 6lowpan interface and I was curious how
this works. At the end it was a "Bluetooth mapping to ethernet header"
(not as tunnel, as propagated). I was not acking it, because if there
are protocols who needs more information than just what you can map to
ethernet... it will not work. At least it will also not work with IEEE
802.15.4 at all. They was just lucky that Bluetooth and ethernet use the
same mac address length (And I had some questions to the multicast bit
as well).

Tunnel might work to get mac information. But so far 6loWPAN works it is
that you have a L2 underlaying interface and on top (ip link set master)
a raw IPv6 interface which do the adaptation automatically as a protocol
translation (That's why I cannot understand Bluetooth 6LoWPAN use tx
queues on their 6LoWPAN interface, they need to fix the queue in the
underlaying L2 interface).

As an alternative solution I think it should be something done like TAP
like interface per subsystem. I mean NO ETHERTNET, but the ethernet in
TAP interfaces out and replace it with Bluetooth or IEEE 802.15.4.
I might can easily create a simple TAP IEEE 802.15.4 to show what I
mean.

With an IEEE 802.15.4 TAP device and a 6lowpan interface on top you can
realize your use case and pass 802.15.4 L2 frames to device node -> pops
up at 6LoPWAN interface and send IPv6 stuff and you can read on device
node.

I am still in the opinion the L2 TAP like interface is the way to go to
offer such feature.

- Alex
