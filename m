Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41747 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803AbcGSVGN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Jul 2016 17:06:13 -0400
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new
 implementation
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-21-aar@pengutronix.de>
 <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de>
 <CABBYNZL0xFGcW_t-eW9hAL8VOLnp4NYL_iKqChJ8B0srBdEgvQ@mail.gmail.com>
 <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de>
 <CABBYNZ+A54MQ3uWGjDVXNOwwX3v3VptZz2UQUNV4_KFKPaV==A@mail.gmail.com>
 <190983bc-9467-8ff8-436c-ca1fcdfe001b@pengutronix.de>
 <20160719054501.GA17979@t440s.P-661HNU-F1>
 <CABBYNZ+epQ6LPP4PfwXAstim_h5yY78GgbVLEH-i96g6u8p_Dw@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <ae47fe95-3599-d3f7-49bf-66c02b067fca@pengutronix.de>
Date: Tue, 19 Jul 2016 23:05:58 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+epQ6LPP4PfwXAstim_h5yY78GgbVLEH-i96g6u8p_Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>, carlesgo@entel.upc.edu


Hi,

On 07/19/2016 10:23 AM, Luiz Augusto von Dentz wrote:
> Hi Alex, Johan,
> 
> On Tue, Jul 19, 2016 at 8:45 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Alex,
>>
...
> 
> Following the recommendation of rfc7668 which say the node should
> always change its address when connecting, which means advertise a
> different address, also the router should periodically change is RPA,
> thus the network interface may have to assume different MAC addresses
> which I don't is currently possible or we are back to having the
> interfaces created on demand.
> 

mhhh, I am not a bluetooth expert. What really means "periodically
change is RPA" and how is this done in the Linux bluetooth?

When "changing the RPA" happens, does that mean the all connections will
be lost (unregister interface). Then the previous connections will be
recreated (register interface) with a complete different MAC address?

I think it will be a complete different MAC address and this happens all
15 minutes.

"The recommended time interval before randomizing new private address is 15
 minutes, as determined by timer T_GAP(private_addr_int) in Table 17.1 of
 the Bluetooth Generic Access Profile [BTCorev4.1]."

If so, then I could understand the reason why recreation of interface.

The only question would for me, how does the bluetooth subsystem handle
such MAC address update with running l2cap channel connections. I
suppose it will close all connections, otherwise the current mainline
solution doesn't work here, because if all channels are disconnected we
get an interface deregister, so far I understood. Afterwards somehow all
connection will be re-established under a new interface, or?

---

Another idea would be stop the interface which allows to change mac
address. Maybe we can have some event handling here, that the mac
address will be changed. If so, such event occur change dev->dev_addr
and open the interface again. stop (ifdown) and open (ifup) with changing
the mac address should be handled by IPv6 applications.

We need at least to run [0] on mac address changes, this reacts on IFUP
and CHANGE netdev notifiers. This will generate the SLAAC address, but
it confuse me somehow to change this address all 15 minutes because the
MAC address changed. :-/

Deregister and register the interface is a no-go in my opinion and we
should have another solution. Especially when such deregister/register
mechanism happens periodically all 15 minutes.

---

I suppose the "RPA" will be the device address which also need to be
filled in as source/target address option in NS/NA/RS/RA then. It's just
difficult to deal with that when the address will be changed
periodically in 15 minutes.

btw: I talked with C. Gomez today, because I am at the IETF. He would
like to help here to make everything clear and agreed that I cc him here.

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L3333
