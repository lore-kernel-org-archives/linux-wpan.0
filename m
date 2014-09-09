Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:42121 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaIINoX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Sep 2014 09:44:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is freed in lowpan_rcv when dropped.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140909094652.GC4545@omega>
Date: Tue, 9 Sep 2014 06:44:56 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <D07925FA-E15D-4465-B20F-FFE52FDCB8CD@holtmann.org>
References: <53DCE75C.2030305@xsilon.com> <20140821083945.GA29484@omega> <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org> <53FE446D.6040805@xsilon.com> <20140908104008.GB6981@omega> <540DF1AE.2070709@xsilon.com> <20140908183652.GA633@omega> <20140908185519.GB633@omega> <540EC844.2040008@xsilon.com> <20140909094652.GC4545@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, linux-zigbee-devel@lists.sourceforge.net, BlueZ development <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org

Hi Alex,

>> 
>> The GHC spec states that a device indicates it's GHC capability using a 6LoWPAN Capability Indication Option (6CIO), this is an ND option.  As far as I can see there is no type assigned yet by IANA so I was wondering if we should have this as an experimental configuration item in the kernel?
> 
> Yes, please make a bool into net/6lowpan/Kconfig and add support for
> drafts only if selected. 
> 
> In code you simple need to use "if (IS_ENABLED(CONFIG_FOO))" to
> registration the nhc format into the nhc framework/layer or not.
> 
> Replace FOO with a propber 6LOWPAN_NHC_DRAFTS or something else. You can
> write in the help what exactly this means.

or you just create /sys/kernel/debug/6lowpan/foo and use debugfs to toggle experimental options on/off at runtime. Especially if you are dealing with not yet assigned types, you can also have an entry that allows you to define the type.

Regards

Marcel

