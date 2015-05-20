Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33470 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbETIzG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 04:55:06 -0400
Received: by wgjc11 with SMTP id c11so45262460wgj.0
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 01:55:04 -0700 (PDT)
Date: Wed, 20 May 2015 10:54:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 2/8] Documentation/networking/ieee802154.txt: fix various
 inaccuracies.
Message-ID: <20150520085454.GA3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195000.GN11014@wantstofly.org>
 <148935A5-4809-4999-9C45-445A9768A7DC@holtmann.org>
 <20150520083630.GU11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150520083630.GU11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

Hi Lennert,

On Wed, May 20, 2015 at 11:36:30AM +0300, Lennert Buytenhek wrote:
> On Wed, May 20, 2015 at 12:05:02AM +0200, Marcel Holtmann wrote:
> 
> > Hi Lennert,
> 
> Hi Marcel,
> 
> 
> > > * Update the linux-zigbee git:// repository URL.
> > > 
> > > * The IEEE 802.15.4 MLME based netlink operations are documented
> > >  in include/linux/nl802154.h, not in include/net/nl802154.h.
> > > 
> > > * The hardmac example driver 'fakehard' was removed some time ago.
> > > 
> > > * The IEEE 802.15.4 device drivers live in drivers/net/ieee802154/,
> > >  not in drivers/ieee802154/.
> > > 
> > > * The IEEE 802.15.4 MTU is 127 bytes, not 128 bytes.
> > > 
> > > * Some of the 6LoWPAN code lives in net/6lowpan/.
> > > 
> > > Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> > > ---
> > > Documentation/networking/ieee802154.txt | 25 ++++++++++++-------------
> > > 1 file changed, 12 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
> > > index 22bbc72..ed08768 100644
> > > --- a/Documentation/networking/ieee802154.txt
> > > +++ b/Documentation/networking/ieee802154.txt
> > > @@ -30,8 +30,8 @@ int sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
> > > 
> > > The address family, socket addresses etc. are defined in the
> > > include/net/af_ieee802154.h header or in the special header
> > > -in our userspace package (see either linux-zigbee sourceforge download page
> > > -or git tree at git://linux-zigbee.git.sourceforge.net/gitroot/linux-zigbee).
> > > +in our userspace package (see either linux-zigbee sourceforge download
> > > +page or git tree at git://git.code.sf.net/p/linux-zigbee/linux-zigbee).
> > 
> > I assumed Alex created a linux-wpan userspace repository. I think
> > if we update the text here, we should reference that one.
> 
> OK, how about this patch instead?  (Want me to resubmit the series?)
> 
> 
> commit fdac3f4b45ad283bf98367d0af4d55e7704d07b5
> Author: Lennert Buytenhek <buytenh@wantstofly.org>
> Date:   Sun May 17 10:53:21 2015 +0300
> 
>     Documentation/networking/ieee802154.txt: fix various inaccuracies.
>     
>     * Update the linux-zigbee git:// repository URL.
>     
>     * The IEEE 802.15.4 MLME based netlink operations are documented
>       in include/linux/nl802154.h, not in include/net/nl802154.h.
>     
>     * The hardmac example driver 'fakehard' was removed some time ago.
>     
>     * The IEEE 802.15.4 device drivers live in drivers/net/ieee802154/,
>       not in drivers/ieee802154/.
>     
>     * The IEEE 802.15.4 MTU is 127 bytes, not 128 bytes.
>     
>     * Some of the 6LoWPAN code lives in net/6lowpan/.
>     
>     Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> 
> diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
> index 22bbc72..b1aea0c 100644
> --- a/Documentation/networking/ieee802154.txt
> +++ b/Documentation/networking/ieee802154.txt
> @@ -30,8 +30,8 @@ int sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
>  
>  The address family, socket addresses etc. are defined in the
>  include/net/af_ieee802154.h header or in the special header
> -in our userspace package (see either linux-zigbee sourceforge download page
> -or git tree at git://linux-zigbee.git.sourceforge.net/gitroot/linux-zigbee).
> +in the userspace package (see either http://wpan.cakelab.org/ or the
> +git tree at https://github.com/linux-wpan/wpan-tools).
>  

ack.

>  One can use SOCK_RAW for passing raw data towards device xmit function. YMMV.
>  
> @@ -53,7 +53,7 @@ MLME - MAC Level Management
>  ============================
>  
>  Most of IEEE 802.15.4 MLME interfaces are directly mapped on netlink commands.
> -See the include/net/nl802154.h header. Our userspace tools package
> +See the include/linux/nl802154.h header. Our userspace tools package

nack. There is no MLME functionality at the moment and there was never a
MLME functionality mainline. What I supposed how this header with these
defines cames mainline, here is the story:

The previous maintainers had implement an netlink _interface_ only and
had run it on _real_ HardMAC transceivers. This was on the sourceforge
kernel which was never be full merged into mainline. So there was some
things which was missing at mainline and doesn't had any functionality.

The point is they never implement MLME ops for SoftMAC transceivers and
to implement an interface only is much easier than implement the logic
behind. Nevertheless at mainline was the fake HardMAC driver which only
notice with some debug messages that this interface was called. It was
just for mlme interface testing.

At the moment this is the deprecated interface and we plan to look into
wireless how they implement MLME ops and such things which have similar
paradigms with SoftMAC and HardMAC transceivers. So I would remove the
whole section about MLME functionality... because we don't support it.

I generally would not care about anything in the old netlink interface,
this should be removed in the next releases.

>  (see above) provides CLI configuration utility for radio interfaces and simple
>  coordinator for IEEE 802.15.4 networks as an example users of MLME protocol.
>  
> @@ -75,8 +75,6 @@ net_device with a pointer to struct ieee802154_mlme_ops instance. The fields
>  assoc_req, assoc_resp, disassoc_req, start_req, and scan_req are optional.
>  All other fields are required.
>  
> -We provide an example of simple HardMAC driver at drivers/ieee802154/fakehard.c
> -
>  

ack.

>  SoftMAC
>  =======
> @@ -89,7 +87,8 @@ stack interface for network sniffers (e.g. WireShark).
>  
>  This layer is going to be extended soon.
>  
> -See header include/net/mac802154.h and several drivers in drivers/ieee802154/.
> +See header include/net/mac802154.h and several drivers in
> +drivers/net/ieee802154/.
>  

ack.

>  
>  Device drivers API
> @@ -114,18 +113,17 @@ Moreover IEEE 802.15.4 device operations structure should be filled.
>  Fake drivers
>  ============
>  
> -In addition there are two drivers available which simulate real devices with
> -HardMAC (fakehard) and SoftMAC (fakelb - IEEE 802.15.4 loopback driver)
> -interfaces. This option provides possibility to test and debug stack without
> -usage of real hardware.
> +In addition there is a driver available which simulates a real device with
> +SoftMAC (fakelb - IEEE 802.15.4 loopback driver) interface. This option
> +provides possibility to test and debug stack without usage of real hardware.
>  
> -See sources in drivers/ieee802154 folder for more details.
> +See sources in drivers/net/ieee802154 folder for more details.
>  

ack.

>  
>  6LoWPAN Linux implementation
>  ============================
>  
> -The IEEE 802.15.4 standard specifies an MTU of 128 bytes, yielding about 80
> +The IEEE 802.15.4 standard specifies an MTU of 127 bytes, yielding about 80

ack.

>  octets of actual MAC payload once security is turned on, on a wireless link
>  with a link throughput of 250 kbps or less.  The 6LoWPAN adaptation format
>  [RFC4944] was specified to carry IPv6 datagrams over such constrained links,
> @@ -140,7 +138,8 @@ In Semptember 2011 the standard update was published - [RFC6282].
>  It deprecates HC1 and HC2 compression and defines IPHC encoding format which is
>  used in this Linux implementation.
>  
> -All the code related to 6lowpan you may find in files: net/ieee802154/6lowpan.*
> +All the code related to 6lowpan you may find in files: net/6lowpan/*
> +and net/ieee802154/6lowpan/*
>  

ack.

- Alex
