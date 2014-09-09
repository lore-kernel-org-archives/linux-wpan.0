Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55070 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbaIILOI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Sep 2014 07:14:08 -0400
Message-ID: <540EE0F4.4090206@xsilon.com>
Date: Tue, 09 Sep 2014 12:13:56 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb
 is freed in lowpan_rcv when dropped.
References: <20140821083945.GA29484@omega> <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org> <53FE446D.6040805@xsilon.com> <20140908104008.GB6981@omega> <540DF1AE.2070709@xsilon.com> <20140908183652.GA633@omega> <20140908185519.GB633@omega> <540EC844.2040008@xsilon.com> <20140909094652.GC4545@omega> <540ED3AB.4000706@xsilon.com> <20140909104754.GA7284@omega>
In-Reply-To: <20140909104754.GA7284@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Alex,

On 09/09/14 11:47, Alexander Aring wrote:
> Hi Martin,
>
> On Tue, Sep 09, 2014 at 11:17:15AM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> On 09/09/14 10:46, Alexander Aring wrote:
>>> Hi Martin,
>>>
>>> On Tue, Sep 09, 2014 at 10:28:36AM +0100, Martin Townsend wrote:
>>> ...
>>>>> I thought more about that, you mean the receiving part only? So the
>>>>> uncompression. The point is that we don't have no interface for an user
>>>>> that can decide if he like to use UDP compression like RFC 6282 or UDP
>>>>> compression like GHC. This is only relevant for the transmit part. So
>>>>> compression is optionally. (We should have some interface to make this
>>>>> configurable by user -> adding this to the nhc layer, later).
>>>> I've implemented compression and decompression. You are right in that we need a mechanism of configuring what gets compressed by what method.
>>> ok. But how we deal with that currently with GHC UDP and UDP RFC6282
>>> compression. We can't not support both compression methods. 
>>>
>>> btw. how we should call it now? Uncompression or decompression, I can
>>> also name the callbacks to decompression. I am not a native speaker so
>>> I will ask you which is better now. :-)
>> As an English speaker I have to admit I don't know.  Here's one link I found on the subject
>> http://english.stackexchange.com/questions/56480/difference-between-uncompress-and-decompress
>> to confuse you even more :)
>>
>>>>> On the uncompression part, means the receiving part we can support both.
>>>>> UDP RFC 6282 or UDP like GHC, the next header id value should be
>>>>> different there. That means currently we can receive every packets but
>>>>> transmit only RFC6282 compression formats.
>>>>>
>>>>> So for receiving this, it's okay. But for compression, since we don't
>>>>> have some interface to make this configurable we should use RFC 6282.
>>>> So I will ensure UDP is compressed by 6282.  Then I was going to start out by just compressing ICMPv6 with GHC and monitor how much data is saved by using GHC.  Later on we will implement a mechanism of configuring what gets compressed and by which compression method.
>>> Okay, you mean that you will leave UDP compression by 6282 but insert a
>>> receive handling (decompression) for UDP GHC?
>>>
>>> RFC6282 doesn't describe any compression/decompression(or uncompression)
>>> format for ICMPv6, so we could handle there compression and
>>> uncompression. I understand now you did it that way, or?
>> For the moment I will assume all ICMPv6 traffic is compressed and decompressed with GHC as this will be the only Next Header Compression format.  In future we need something better.  We also need a method of knowing what compression formats a device supports.  I can see a list of compression formats which could also be a list by protocol.  Then when sending to a device you would select the highest ranking supported compression format for that device.
> Is "what compression methods like a device to use" part of any RFC? Is there
> something which I don't know? I mean, okay you can do that in any
> application layer in userspace. But I don't see that we need something
> like this in kernelspace. I know there is no suggestion that you want to
> implement something like this in kernelspace, but I want to clarify this.
>
> Application layer in userspace means, use some own coap(or whatever) based
> protocol and setup the right compressions via userspace by some application.

I don't know what would be implemented in user or kernel space it's just a general observation that we need some mechanism in the future, of knowing what capabilities a device we want to send to supports so we can select compression accordingly.


> - Alex

- Martin.
