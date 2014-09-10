Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53676 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbaIJATG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Sep 2014 20:19:06 -0400
Date: Wed, 10 Sep 2014 02:18:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
Message-ID: <20140910001855.GA12221@omega>
References: <20140821083945.GA29484@omega>
 <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
 <53FE446D.6040805@xsilon.com>
 <20140908104008.GB6981@omega>
 <540DF1AE.2070709@xsilon.com>
 <20140908183652.GA633@omega>
 <20140908185519.GB633@omega>
 <540EC844.2040008@xsilon.com>
 <20140909094652.GC4545@omega>
 <D07925FA-E15D-4465-B20F-FFE52FDCB8CD@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D07925FA-E15D-4465-B20F-FFE52FDCB8CD@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Martin Townsend <martin.townsend@xsilon.com>, linux-zigbee-devel@lists.sourceforge.net, BlueZ development <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org

Hi Marcel,

On Tue, Sep 09, 2014 at 06:44:56AM -0700, Marcel Holtmann wrote:
> Hi Alex,
> 
> >> 
> >> The GHC spec states that a device indicates it's GHC capability using a 6LoWPAN Capability Indication Option (6CIO), this is an ND option.  As far as I can see there is no type assigned yet by IANA so I was wondering if we should have this as an experimental configuration item in the kernel?
> > 
> > Yes, please make a bool into net/6lowpan/Kconfig and add support for
> > drafts only if selected. 
> > 
> > In code you simple need to use "if (IS_ENABLED(CONFIG_FOO))" to
> > registration the nhc format into the nhc framework/layer or not.
> > 
> > Replace FOO with a propber 6LOWPAN_NHC_DRAFTS or something else. You can
> > write in the help what exactly this means.
> 
> or you just create /sys/kernel/debug/6lowpan/foo and use debugfs to toggle experimental options on/off at runtime. Especially if you are dealing with not yet assigned types, you can also have an entry that allows you to define the type.
> 

yea, runtime changeable stuff is nice. I will try to add some debugfs
entry registration with the nhc framework/layer. Then Martin can add
an entry to enable/disable his experimental stuff.

Thanks.

- Alex
