Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63132 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411AbaIIKR3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Sep 2014 06:17:29 -0400
Message-ID: <540ED3AB.4000706@xsilon.com>
Date: Tue, 09 Sep 2014 11:17:15 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb
 is freed in lowpan_rcv when dropped.
References: <53DCE75C.2030305@xsilon.com> <20140821083945.GA29484@omega> <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org> <53FE446D.6040805@xsilon.com> <20140908104008.GB6981@omega> <540DF1AE.2070709@xsilon.com> <20140908183652.GA633@omega> <20140908185519.GB633@omega> <540EC844.2040008@xsilon.com> <20140909094652.GC4545@omega>
In-Reply-To: <20140909094652.GC4545@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Alex,

On 09/09/14 10:46, Alexander Aring wrote:
> Hi Martin,
>
> On Tue, Sep 09, 2014 at 10:28:36AM +0100, Martin Townsend wrote:
> ...
>>> I thought more about that, you mean the receiving part only? So the
>>> uncompression. The point is that we don't have no interface for an user
>>> that can decide if he like to use UDP compression like RFC 6282 or UDP
>>> compression like GHC. This is only relevant for the transmit part. So
>>> compression is optionally. (We should have some interface to make this
>>> configurable by user -> adding this to the nhc layer, later).
>> I've implemented compression and decompression. You are right in that we need a mechanism of configuring what gets compressed by what method.
> ok. But how we deal with that currently with GHC UDP and UDP RFC6282
> compression. We can't not support both compression methods. 
>
> btw. how we should call it now? Uncompression or decompression, I can
> also name the callbacks to decompression. I am not a native speaker so
> I will ask you which is better now. :-)
As an English speaker I have to admit I don't know.  Here's one link I found on the subject
http://english.stackexchange.com/questions/56480/difference-between-uncompress-and-decompress
to confuse you even more :)

>
>>> On the uncompression part, means the receiving part we can support both.
>>> UDP RFC 6282 or UDP like GHC, the next header id value should be
>>> different there. That means currently we can receive every packets but
>>> transmit only RFC6282 compression formats.
>>>
>>> So for receiving this, it's okay. But for compression, since we don't
>>> have some interface to make this configurable we should use RFC 6282.
>> So I will ensure UDP is compressed by 6282.  Then I was going to start out by just compressing ICMPv6 with GHC and monitor how much data is saved by using GHC.  Later on we will implement a mechanism of configuring what gets compressed and by which compression method.
> Okay, you mean that you will leave UDP compression by 6282 but insert a
> receive handling (decompression) for UDP GHC?
>
> RFC6282 doesn't describe any compression/decompression(or uncompression)
> format for ICMPv6, so we could handle there compression and
> uncompression. I understand now you did it that way, or?
For the moment I will assume all ICMPv6 traffic is compressed and decompressed with GHC as this will be the only Next Header Compression format.  In future we need something better.  We also need a method of knowing what compression formats a device supports.  I can see a list of compression formats which could also be a list by protocol.  Then when sending to a device you would select the highest ranking supported compression format for that device.
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
>> The GHC spec states that a device indicates it's GHC capability using a 6LoWPAN Capability Indication Option (6CIO), this is an ND option.  As far as I can see there is no type assigned yet by IANA so I was wondering if we should have this as an experimental configuration item in the kernel?
> Yes, please make a bool into net/6lowpan/Kconfig and add support for
> drafts only if selected. 
>
> In code you simple need to use "if (IS_ENABLED(CONFIG_FOO))" to
> registration the nhc format into the nhc framework/layer or not.
>
> Replace FOO with a propber 6LOWPAN_NHC_DRAFTS or something else. You can
> write in the help what exactly this means.
>
> - Alex

- Martin
