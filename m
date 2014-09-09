Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52921 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbaIIKAE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Sep 2014 06:00:04 -0400
Date: Tue, 9 Sep 2014 11:59:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
Message-ID: <20140909095958.GD4545@omega>
References: <53DCE75C.2030305@xsilon.com>
 <20140821083945.GA29484@omega>
 <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
 <53FE446D.6040805@xsilon.com>
 <20140908104008.GB6981@omega>
 <540DF1AE.2070709@xsilon.com>
 <20140908183652.GA633@omega>
 <20140908185519.GB633@omega>
 <540EC844.2040008@xsilon.com>
 <20140909094652.GC4545@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140909094652.GC4545@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

On Tue, Sep 09, 2014 at 11:46:52AM +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Tue, Sep 09, 2014 at 10:28:36AM +0100, Martin Townsend wrote:
> ...
> > > I thought more about that, you mean the receiving part only? So the
> > > uncompression. The point is that we don't have no interface for an user
> > > that can decide if he like to use UDP compression like RFC 6282 or UDP
> > > compression like GHC. This is only relevant for the transmit part. So
> > > compression is optionally. (We should have some interface to make this
> > > configurable by user -> adding this to the nhc layer, later).
> > I've implemented compression and decompression. You are right in that we need a mechanism of configuring what gets compressed by what method.
> 
> ok. But how we deal with that currently with GHC UDP and UDP RFC6282
> compression. We can't not support both compression methods. 
> 
> btw. how we should call it now? Uncompression or decompression, I can
> also name the callbacks to decompression. I am not a native speaker so
> I will ask you which is better now. :-)
> 
> > > On the uncompression part, means the receiving part we can support both.
> > > UDP RFC 6282 or UDP like GHC, the next header id value should be
> > > different there. That means currently we can receive every packets but
> > > transmit only RFC6282 compression formats.
> > >
> > > So for receiving this, it's okay. But for compression, since we don't
> > > have some interface to make this configurable we should use RFC 6282.
> > So I will ensure UDP is compressed by 6282.  Then I was going to start out by just compressing ICMPv6 with GHC and monitor how much data is saved by using GHC.  Later on we will implement a mechanism of configuring what gets compressed and by which compression method.
> 
> Okay, you mean that you will leave UDP compression by 6282 but insert a
> receive handling (decompression) for UDP GHC?
> 
> RFC6282 doesn't describe any compression/decompression(or uncompression)
> format for ICMPv6, so we could handle there compression and
> uncompression. I understand now you did it that way, or?
> 
> About the mechanism by user:
> 
> There are several ways about to do it from userspace. I know now sysfs
> or netlink. Do you have already some idea how you want to make this
> configurable by user?
> 
> 
> btw.
> This reminds me a little bit like setting led trigger type, (blink,
> heartbeat, mmc, net, etc...). This is done by sysfs. 
> 
> > 
> > The GHC spec states that a device indicates it's GHC capability using a 6LoWPAN Capability Indication Option (6CIO), this is an ND option.  As far as I can see there is no type assigned yet by IANA so I was wondering if we should have this as an experimental configuration item in the kernel?
> 
> Yes, please make a bool into net/6lowpan/Kconfig and add support for
> drafts only if selected. 
> 
> In code you simple need to use "if (IS_ENABLED(CONFIG_FOO))" to
> registration the nhc format into the nhc framework/layer or not.

Forget this one, I failed here. We should complete get out the draft
implementations when it's not selected by buildsystem.

We need something like this here. "Adding dummy functions with ifdefs".

#idef CONFIG_FOO
/* real prototype */
int lowpan_nhc_add_fancy_format(foo);
...
#else
static inline int lowpan_nhc_add_fancy_format(foo) { }
...
#endif

also according to Makefile that we don't build the files which
implements "lowpan_nhc_add_fancy_format".

- Alex
