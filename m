Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61482 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbAIN4D (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Jan 2015 08:56:03 -0500
Date: Fri, 9 Jan 2015 14:55:55 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv4 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Message-ID: <20150109135552.GA8115@omega>
References: <1420720298-1995-1-git-send-email-alex.aring@gmail.com>
 <BD3A316F-B094-419D-B2EC-EF6D980A692A@holtmann.org>
 <058601d02b77$f3f47050$dbdd50f0$@samsung.com>
 <20150108200443.GB2046@omega>
 <05f001d02c0c$ede01620$c9a04260$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05f001d02c0c$ede01620$c9a04260$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: 'Marcel Holtmann' <marcel@holtmann.org>, 'BlueZ development' <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, 'Jukka Rissanen' <jukka.rissanen@linux.intel.com>, 'Martin Townsend' <mtownsend1973@gmail.com>

Hi,

On Fri, Jan 09, 2015 at 01:05:22PM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 08/01/15 21:04, Alexander Aring wrote:
> >Hi,
> >
> >On Thu, Jan 08, 2015 at 07:18:57PM +0000, Stefan Schmidt wrote:
> >...
> >>>>net/6lowpan/nhc.h               | 146 ++++++++++++++++++++++++
> >>>>net/6lowpan/nhc_rfc6282_dest.c  |  27 +++++
> >>>>net/6lowpan/nhc_rfc6282_frag.c  |  26 +++++
> >>>>net/6lowpan/nhc_rfc6282_hop.c   |  26 +++++
> >>>>net/6lowpan/nhc_rfc6282_ipv6.c  |  26 +++++
> >>>>net/6lowpan/nhc_rfc6282_mobil.c |  26 +++++
> >>>>net/6lowpan/nhc_rfc6282_route.c |  26 +++++
> >>>>net/6lowpan/nhc_rfc6282_udp.c   | 156 ++++++++++++++++++++++++++
> >>>
> >>>can we please remove the _rfc6282 from the filenames. RFCs get update and
> >>>thus change numbers. I do not want to carry RFC numbers in filenames
> >>>around. There is also almost no precedence in the kernel source code that
> >>>would justify doing this.
> >>
> >>They look indeed quite ugly in the filename. :)
> >>
> >>Moving them as a comment and starting point into the file should be
> >>enough.
> >>Maybe we can also rename nhc_mobil to nhc_mobility. The other
> >>abbreviations
> >>are clear in my opinion but for mobil I actually opened the rfc to look
> >>what
> >>you mean here.
> >>
> >
> >For the rfc6282 thing:
> >
> >Currently there exists two RFCs which describes an UDP compression. It's
> >rfc6282 (the well known 6LoWPAN IPHC compression RFC) and RFC7400 which
> >was pointed out by Martin Townsend [0].
> 
> November 2014, thats really new.
> 
> >We need to clarify how we should deal with multiple definitions for a
> >compression format. On receiving side we should always support what we
> >can which is decided by the variable nhcid length. While on transmit...
> >we need still some configuration interface (my dreams are to decide the
> >compression methods per socket, don't know how possible that is).
> 
> As a general rule we should try to accept, identify and uncompress as many
> formats for the incoming side. For the sending side this decision is very
> unlikely to be made by the application but instead it is made by the system
> configurator / platform. Thus in my eyes it makes more sense to have the
> configure options either via netlink or sysfs but not over the socket
> interface.
> 

yes, this is the next part which is also more easier than the per socket
interface. To make this just per socket is more granularity than have a
"global setting" for this. Maybe we can handle this in one net namespace
configuration, but this also seems after the a step to introduce a netlink
configuration framework. I already talked with Jukka and he also agree For
a netlink interface (this was in some previous series).

> >For the handling I thought that we have then two UDP nhc modules, both
> >can be loaded (at the moment _only_ one UDP nhc compressression should
> >implement the compress methods, both should implement uncompression
> >methods).
> >
> >I can rename it to nhc_udp.c for the standard compression methods
> >according to rfc6282, I am fine with that. But later there exists then
> >an another compression module with the naming "nhc_ghc_udp.c" or
> >something else. So we have "nhc_udp.ko" and "nhc_ghc_udp.ko".
> >Is that okay for everybody?
> 
> It would be ok for me. nhc_udp is the earlier spec and thus has a shorter
> name while we need to distinguish for later specs and add the ghc for it. In
> a later mail you mentioned using _iphc_ and _ghc_ I would avoid that because
> GHC is just plugged into NHC and thus is also a under the IPHC umbrella of
> compressions. :)
> 

ok.

> >Maybe I should also add some modinfo information, which containing the
> >nhc->name.
> 
> Maybe. For what would it be used? Having a human readable description would
> make sense for the configure interface in some cases I would say.
> 

For `modinfo $NHC_MODULE`.

> >For the nexthdr names:
> >
> >I will try to change it according to the NEXTHDR IPv6 defines [1], so also
> >the linux IPv6 guys knows what it is.
> 
> That looks good to me.
>

ok.

- Alex
